import 'package:flutter/material.dart';
import '../routes.dart';

class SubwubDrawer extends StatelessWidget {
  const SubwubDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(children: [
      DrawerHeader(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("hedgepigdaniel", style: TextStyle(fontSize: 16)),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Text("https://airsonic.danielplayfaircal.com"),
                ),
              ])),
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
