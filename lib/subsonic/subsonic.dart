import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:http/http.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:math';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subsonic.freezed.dart';
part 'subsonic.g.dart';

sealed class SubsonicResult<Content> {}

class SubsonicError<Content> extends SubsonicResult<Content> {
  final Exception error;
  SubsonicError(this.error);
}

class SubsonicApiError<Content> extends SubsonicResult<Content> {
  final String status;
  final int code;
  final String message;
  SubsonicApiError(
      {required this.status, required this.code, required this.message});
}

class SubsonicApiSuccess<Content> extends SubsonicResult<Content> {
  final String status;
  final String version;
  final Content content;
  SubsonicApiSuccess(
      {required this.status, required this.version, required this.content});
}

@freezed
class SubsonicArtist with _$SubsonicArtist {
  const factory SubsonicArtist({
    required String id,
    required String name,
    required int albumCount,
    required String coverArt,
    required String artistImageUrl,
  }) = _SubsonicArtist;

  factory SubsonicArtist.fromJson(Map<String, Object?> json) =>
      _$SubsonicArtistFromJson(json);
}

@freezed
class SubsonicArtistIndexEntry with _$SubsonicArtistIndexEntry {
  const factory SubsonicArtistIndexEntry({
    required String name,
    required IList<SubsonicArtist> artist,
  }) = _SubsonicArtistIndexEntry;

  factory SubsonicArtistIndexEntry.fromJson(Map<String, Object?> json) =>
      _$SubsonicArtistIndexEntryFromJson(json);
}

@freezed
class SubsonicArtistIndex with _$SubsonicArtistIndex {
  const factory SubsonicArtistIndex({
    required IList<SubsonicArtistIndexEntry> index,
    required String ignoredArticles,
  }) = _SubsonicArtistIndex;

  factory SubsonicArtistIndex.fromJson(Map<String, Object?> json) =>
      _$SubsonicArtistIndexFromJson(json);
}

@freezed
class SubsonicArtists with _$SubsonicArtists {
  const factory SubsonicArtists({
    required SubsonicArtistIndex artists,
  }) = _SubsonicArtists;

  factory SubsonicArtists.fromJson(Map<String, Object?> json) =>
      _$SubsonicArtistsFromJson(json);
}

class SubsonicClient {
  final Uri _serverUrl;
  final String _username;
  final String _password;

  SubsonicClient(
      {required Uri serverUrl,
      required String username,
      required String password})
      : _password = password,
        _username = username,
        _serverUrl = serverUrl;

  Future<SubsonicResult<void>> ping() =>
      _callSubsonic(path: "/rest/ping", parseContent: (response) => {});

  Future<SubsonicResult<SubsonicArtists>> getArtists() => _callSubsonic(
        path: "/rest/getArtists",
        parseContent: (response) => SubsonicArtists.fromJson(response),
      );

  Future<SubsonicResult<Content>> _callSubsonic<Content>({
    required path,
    required Content Function(dynamic) parseContent,
  }) async {
    Response response;
    try {
      response = await _doRequest(path: path, queryParams: const {});
    } on Exception catch (error) {
      return SubsonicError(error);
    }
    try {
      var result = json.decode(response.body);
      // print(prettyJson(result));
      var subsonicResponse = result['subsonic-response'];
      if (subsonicResponse['status'] == "ok") {
        return SubsonicApiSuccess(
          status: subsonicResponse['status'],
          version: subsonicResponse['version'],
          content: parseContent(subsonicResponse),
        );
      } else {
        return SubsonicApiError(
          status: subsonicResponse['status'],
          code: subsonicResponse['code'],
          message: subsonicResponse['message'],
        );
      }
    } on Error catch (error) {
      return SubsonicError(Exception("Failed to parse API response"));
    }
  }

  Future<Response> _doRequest({
    required String path,
    required Map<String, String> queryParams,
  }) async {
    String salt = _generateSalt();
    String token = _generateToken(salt);
    return await get(_serverUrl.resolve(path).replace(
      queryParameters: {
        ...queryParams,
        "u": _username,
        "t": token,
        "s": salt,
        "v": "1.15.0",
        "c": "Subwub",
        "f": "json",
      },
    ));
  }

  String _generateToken(String salt) {
    return md5.convert(utf8.encode(_password + salt)).toString();
  }

  static String _generateSalt() => _generateSecureRandomString(12);

  static _generateSecureRandomString(int len) {
    var r = Random.secure();
    return String.fromCharCodes(
      List.generate(len, (index) => r.nextInt(26) + 65),
    );
  }
}
