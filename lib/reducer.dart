import 'package:subwub/actions.dart';

import './state.dart';

AppState reducer(AppState state, dynamic actionDynamic) {
  AppAction action = actionDynamic;
  switch (action) {
    case UpsertUserAccount():
      return state.rebuild((builder) => builder.userAccounts.addAll({
            UserAccountKey((builder) {
              builder.serverUrl = action.serverUrl.toString();
              builder.username = action.username;
            }): UserAccountValue((builder) {
              builder.password = action.password;
            }),
          }));
  }
}
