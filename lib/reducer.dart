import 'package:subwub/actions.dart';

import './state.dart';

AppState reducer(AppState state, dynamic actionDynamic) {
  AppAction action = actionDynamic;
  switch (action) {
    case UpsertUserAccount():
      UserAccount user = UserAccount(
        password: action.password,
        serverUrl: action.serverUrl.toString(),
        username: action.username,
      );
      return state.copyWith(
        userAccounts: state.userAccounts.add(
          user.key,
          user,
        ),
        currentUserAccount: user.key,
      );
  }
}
