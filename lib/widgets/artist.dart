import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:subwub/actions.dart';
import 'package:subwub/selectors/current-user-account-artists.dart';
import 'package:subwub/selectors/current-user-account.dart';
import 'package:subwub/selectors/select-album-ids-by-artist.dart';
import 'package:subwub/selectors/select-artist-by-id.dart';
import 'package:subwub/state.dart';
import 'package:subwub/subsonic/subsonic.dart';

import '../selectors/select-album-by-id.dart';

class ArtistViewModel {
  ArtistViewModel({
    required this.userAccount,
    required this.dispatch,
    required this.artist,
  });

  final UserAccount userAccount;
  final dynamic Function(dynamic) dispatch;
  final SubsonicArtist artist;
}

class Artist extends StatelessWidget {
  const Artist({super.key, required this.artistId});

  final String artistId;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ArtistViewModel>(
      builder: (context, model) => Artist_(
        userAccount: model.userAccount,
        artist: model.artist,
        dispatch: model.dispatch,
      ),
      converter: (store) => ArtistViewModel(
        userAccount: selectCurrentUserAccount(store.state)!,
        artist: makeSelectArtistById(artistId)(store.state)!,
        dispatch: store.dispatch,
      ),
    );
  }
}

class Artist_ extends StatefulWidget {
  const Artist_({
    super.key,
    required this.userAccount,
    required this.artist,
    required this.dispatch,
  });

  final UserAccount userAccount;
  final dynamic Function(dynamic) dispatch;
  final SubsonicArtist artist;

  @override
  State<Artist_> createState() => _ArtistState();
}

class _ArtistState extends State<Artist_> {
  @override
  void initState() {
    super.initState();

    UserAccount userAccount = widget.userAccount;

    SubsonicClient client = SubsonicClient(
      serverUrl: Uri.parse(userAccount.serverUrl),
      username: userAccount.username,
      password: userAccount.password,
    );
    loadData(client, userAccount);
  }

  void loadData(SubsonicClient client, UserAccount userAccount) async {
    var result = await client.getArtist(artistId: widget.artist.id);
    switch (result) {
      case SubsonicApiSuccess():
        widget.dispatch(SubsonicGetArtistResponseAction(
          artist: result.content,
          userAccount: userAccount.key,
        ));

      default:
        print(result);
        throw Exception("Failed to fetch artist info :(");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.artist.name)),
      body: AlbumsList(artistId: widget.artist.id),
    );
  }
}

class AlbumsList extends StatelessWidget {
  const AlbumsList({super.key, required this.artistId});

  final String artistId;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, IList<String>?>(
      builder: (context, albums) {
        if (albums == null) {
          return const Text("Loading...");
        } else {
          return ListView.builder(
            itemBuilder: (context, index) {
              if (albums.length <= index) {
                return null;
              }
              return Album(albumId: albums.get(index));
            },
          );
        }
      },
      converter: (store) => makeSelectAlbumIdsByArtistId(artistId)(store.state),
    );
  }
}

class Album extends StatelessWidget {
  const Album({super.key, required this.albumId});

  final String albumId;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, SubsonicAlbum>(
      builder: (context, album) => ListTile(title: Text(album.name)),
      converter: (store) => makeSelectAlbumById(albumId)(store.state)!,
    );
  }
}
