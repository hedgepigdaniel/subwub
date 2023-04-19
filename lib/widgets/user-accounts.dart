import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:subwub/state.dart';

import '../routes.dart';

class UserAccounts extends StatelessWidget {
  const UserAccounts({super.key});

  @override
  Widget build(context) => Scaffold(
        appBar: AppBar(),
        body: StoreConnector<AppState, Iterable<UserAccountKey>>(
          converter: (store) => store.state.userAccounts.keys,
          builder: (context, userAccounts) => Column(
            children: [
              ...userAccounts.map((user) => ListTile(
                    title: Text(user.serverUrl),
                    subtitle: Text(user.username),
                  ))
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, Routes.addUserAccount.path);
            }),
      );
}
