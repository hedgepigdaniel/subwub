import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:subwub/actions.dart';
import 'package:subwub/selectors/current-user-account-artists.dart';
import 'package:subwub/selectors/current-user-account.dart';
import 'package:subwub/state.dart';
import 'package:subwub/subsonic/subsonic.dart';

class ArtistsViewModel {
  ArtistsViewModel({
    required this.userAccount,
    required this.dispatch,
    required this.artists,
  });

  final UserAccount? userAccount;
  final dynamic Function(dynamic) dispatch;
  final IList<SubsonicArtist>? artists;
}

class Artists extends StatelessWidget {
  const Artists({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ArtistsViewModel>(
      builder: (context, model) => Artists_(
        userAccount: model.userAccount,
        artists: model.artists ?? IList(const []),
        dispatch: model.dispatch,
      ),
      converter: (store) => ArtistsViewModel(
        userAccount: selectCurrentUserAccount(store.state),
        artists: selectCurrentUserAccountArtists(store.state),
        dispatch: store.dispatch,
      ),
    );
  }
}

class Artists_ extends StatefulWidget {
  const Artists_({
    super.key,
    required this.userAccount,
    required this.artists,
    required this.dispatch,
  });

  final UserAccount? userAccount;
  final IList<SubsonicArtist> artists;
  final dynamic Function(dynamic) dispatch;

  @override
  State<Artists_> createState() => _ArtistsState();
}

class _ArtistsState extends State<Artists_> {
  @override
  void initState() {
    super.initState();

    UserAccount? userAccount = widget.userAccount;

    if (userAccount == null) {
      return;
    }
    SubsonicClient client = SubsonicClient(
      serverUrl: Uri.parse(userAccount.serverUrl),
      username: userAccount.username,
      password: userAccount.password,
    );
    loadData(client, userAccount);
  }

  void loadData(SubsonicClient client, UserAccount userAccount) async {
    var result = await client.getArtists();
    switch (result) {
      case SubsonicApiSuccess():
        widget.dispatch(SubsonicArtistsIndexResponse(
          userAccount: userAccount.key,
          index: result.content.artists,
        ));

      default:
        print(result);
        throw Exception("Failed to fetch artists :(");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        if (widget.artists.length <= index) {
          return null;
        }
        var artist = widget.artists.get(index);
        return ListTile(title: Text(artist.name));
      },
    );
  }
}
