import 'package:redux/redux.dart';
import '../subsonic/subsonic.dart';

sealed class AppAction {}

typedef Dispatch = void Function(AppAction action);

Dispatch convertDispatch(Store<dynamic> store) => (AppAction action) {
      store.dispatch(action);
    };

class UpsertUserAccountAction extends AppAction {
  UpsertUserAccountAction({
    required this.serverUrl,
    required this.username,
    required this.password,
  });

  final Uri serverUrl;
  final String username;
  final String password;
}

class SubsonicGetArtistsResponseAction extends AppAction {
  SubsonicGetArtistsResponseAction({
    required this.index,
    required this.userAccount,
  });

  final SubsonicArtistIndex index;
  final String userAccount;
}

class SubsonicGetArtistResponseAction extends AppAction {
  SubsonicGetArtistResponseAction({
    required this.artist,
    required this.userAccount,
  });

  final SubsonicGetArtistResponse artist;
  final String userAccount;
}
