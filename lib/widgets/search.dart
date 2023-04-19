import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          title: const Row(children: [
            Expanded(
                child: TextField(
              autofocus: true,
              decoration: InputDecoration(hintText: "Search music"),
            )),
          ]),
        ),
        body: const Center(child: Text("Results")),
      );
}
