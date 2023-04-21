import 'package:subwub/actions.dart';

import './state.dart';

AppState reducer(AppState state, dynamic actionDynamic) {
  AppAction action = actionDynamic;
  switch (action) {
    case UpsertUserAccount():
      return state.copyWith(
          userAccounts: state.userAccounts.add(
        UserAccountKey(
          serverUrl: action.serverUrl.toString(),
          username: action.username,
        ),
        UserAccountValue(password: action.password),
      ));
  }
}
