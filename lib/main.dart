import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const SubwubApp());
}

class SubwubApp extends StatelessWidget {
  const SubwubApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        '/': (context) => SubwubHomePage(),
        '/search': (context) => const SubwubSearch(),
      },
    );
  }
}

class SubwubSearch extends StatelessWidget {
  const SubwubSearch({super.key});

  @override
  Widget build(context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).dialogBackgroundColor,
          title: Row(children: const [
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

class SubwubHomePage extends StatelessWidget {
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
                  Navigator.pushNamed(context, '/search');
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
            Center(child: Text("Artists")),
            Center(child: Text("Albums")),
            Center(child: Text("Songs")),
          ],
        ),
      ),
    );
  }
}

class SubwubDrawer extends StatelessWidget {
  const SubwubDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Drawer();
  }
}
