import 'package:flutter/material.dart';

import '../routes.dart';

class UserAccounts extends StatelessWidget {
  const UserAccounts({super.key});

  @override
  Widget build(context) => Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text("User accounts")),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, Routes.addUserAccount.path);
            }),
      );
}
