import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../subsonic/subsonic.dart';

part 'state.freezed.dart';
part 'state.g.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    String? currentUserAccount,
    @Default(IMapConst({})) IMap<String, UserState> stateByUserId,
  }) = _AppState;

  factory AppState.fromJson(Map<String, Object?> json) =>
      _$AppStateFromJson(json);
}

@freezed
class UserAccount with _$UserAccount {
  const UserAccount._();

  const factory UserAccount({
    required String serverUrl,
    required String username,
    required String password,
  }) = _UserAccount;

  String get key => Uri.parse(serverUrl).replace(userInfo: username).toString();

  factory UserAccount.fromJson(Map<String, Object?> json) =>
      _$UserAccountFromJson(json);
}

@freezed
class UserState with _$UserState {
  const factory UserState({
    required UserAccount userAccount,
    @Default(IListConst<String>([]))
        IList<String> sortedArtistIds,
    @Default(IMapConst<String, SubsonicArtist>({}))
        IMap<String, SubsonicArtist> artistsById,
    @Default(IMapConst<String, SubsonicAlbum>({}))
        IMap<String, SubsonicAlbum> albumsById,
    @Default(IMapConst<String, IList<String>>({}))
        IMap<String, IList<String>> albumIdsByArtistId,
  }) = _UserState;

  factory UserState.fromJson(Map<String, Object?> json) =>
      _$UserStateFromJson(json);
}
