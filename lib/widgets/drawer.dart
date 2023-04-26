import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:subwub/state.dart';
import '../routes.dart';

class SubwubDrawer extends StatelessWidget {
  const SubwubDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      DrawerHeader(
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: StoreConnector<AppState, UserAccount?>(
          converter: (store) {
            String? currentUserAccount = store.state.currentUserAccount;
            if (currentUserAccount != null) {
              UserState? userState =
                  store.state.stateByUserId[currentUserAccount];
              if (userState != null) {
                return userState.userAccount;
              } else {
                return null;
              }
            } else {
              return null;
            }
          },
          builder: (context, currentUserAccount) {
            if (currentUserAccount == null) {
              throw Error();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(currentUserAccount.username,
                      style: const TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(currentUserAccount.serverUrl),
                ),
              ],
            );
          },
        ),
      ),
      ListTile(
          leading: const Icon(Icons.person),
          title: const Text("Accounts"),
          onTap: () {
            Navigator.pushNamed(context, Routes.userAccounts.path);
          }),
      const ListTile(
        leading: Icon(Icons.settings),
        title: Text("Settings"),
      )
    ]));
  }
}
