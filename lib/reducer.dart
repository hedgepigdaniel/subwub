import 'package:subwub/actions.dart';

import './state.dart';

AppState reducer(AppState state, dynamic actionDynamic) {
  AppAction action = actionDynamic;
  switch (action) {
    case UpsertUserAccount():
      UserAccountKey key = UserAccountKey(
        serverUrl: action.serverUrl.toString(),
        username: action.username,
      );
      return state.copyWith(
        userAccounts: state.userAccounts.add(
          key,
          UserAccountValue(password: action.password),
        ),
        currentUserAccount: key,
      );
  }
}
