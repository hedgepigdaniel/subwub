import 'package:flutter/material.dart';
import '../routes.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Subwub"),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("Welcome to Subwub!"),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.addUserAccount.path);
              },
              child: const Text("Add account"),
            ),
          ],
        ),
      ),
    );
  }
}
