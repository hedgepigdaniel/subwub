import 'package:redux/redux.dart';
import '../subsonic/subsonic.dart';

sealed class AppAction {}

typedef Dispatch = void Function(AppAction action);

Dispatch convertDispatch(Store<dynamic> store) => (AppAction action) {
      store.dispatch(action);
    };

class UpsertUserAccount extends AppAction {
  UpsertUserAccount({
    required this.serverUrl,
    required this.username,
    required this.password,
  });

  final Uri serverUrl;
  final String username;
  final String password;
}

class SubsonicArtistsIndexResponse extends AppAction {
  SubsonicArtistsIndexResponse({
    required this.index,
    required this.userAccount,
  });

  final SubsonicArtistIndex index;
  final String userAccount;
}
