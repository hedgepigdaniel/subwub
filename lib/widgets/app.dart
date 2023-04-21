import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:subwub/widgets/welcome.dart';

import '../routes.dart';
import '../state.dart';

import 'search.dart';
import 'home.dart';
import 'user-accounts.dart';
import 'add-user-account.dart';

class App extends StatelessWidget {
  App({super.key, required Store<AppState> this.store});

  final Store<AppState> store;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: StoreConnector<AppState, bool>(
        converter: (store) => store.state.currentUserAccount != null,
        builder: (context, hasUserAccount) => MaterialApp(
          title: 'Subwub',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.red,
              brightness: Brightness.light,
            ),
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.red,
              brightness: Brightness.dark,
            ),
          ),
          initialRoute: hasUserAccount ? Routes.home.path : Routes.welcome.path,
          routes: {
            Routes.home.path: (context) => Home(),
            Routes.welcome.path: (context) => const Welcome(),
            Routes.search.path: (context) => const Search(),
            Routes.userAccounts.path: (context) => const UserAccounts(),
            Routes.addUserAccount.path: (context) => AddUserAccount(
                  onComplete: () {
                    if (hasUserAccount) {
                      Navigator.pop(context);
                    } else {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.home.path,
                        (route) => false,
                      );
                    }
                  },
                ),
          },
        ),
      ),
    );
  }
}
