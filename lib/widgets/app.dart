import 'package:flutter/material.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:subwub/reducer.dart';
import 'package:subwub/routes.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../state.dart';
import 'search.dart';
import 'home.dart';
import 'user-accounts.dart';
import 'add-user-account.dart';

class App extends StatelessWidget {
  App({super.key});

  final store = Store(
    reducer,
    initialState: AppState(),
    middleware: [LoggingMiddleware.printer()],
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
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
        initialRoute: '/',
        routes: {
          Routes.home.path: (context) => Home(),
          Routes.search.path: (context) => const Search(),
          Routes.userAccounts.path: (context) => const UserAccounts(),
          Routes.addUserAccount.path: (context) => const AddUserAccount(),
        },
      ),
    );
  }
}
