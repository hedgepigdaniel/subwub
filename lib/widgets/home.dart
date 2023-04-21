import 'package:flutter/material.dart';
import '../routes.dart';
import './drawer.dart';
import 'artists.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
            title: const Text("Subwub"),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                tooltip: "Search",
                onPressed: () {
                  Navigator.pushNamed(context, Routes.search.path);
                },
              ),
            ],
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.person)),
                Tab(icon: Icon(Icons.album)),
                Tab(icon: Icon(Icons.music_note)),
              ],
            )),
        drawer: const SubwubDrawer(),
        body: const TabBarView(
          children: [
            Artists(),
            Center(child: Text("Albums")),
            Center(child: Text("Songs")),
          ],
        ),
      ),
    );
  }
}
