import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

import 'package:subwub/subsonic/subsonic.dart';

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
        '/user-accounts': (context) => const UserAccounts(),
        '/user-accounts/add': (context) => const AddUserAccount(),
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

class UserAccounts extends StatelessWidget {
  const UserAccounts({super.key});

  @override
  Widget build(context) => Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text("User accounts")),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/user-accounts/add');
            }),
      );
}

class AddUserAccount extends StatefulWidget {
  const AddUserAccount({super.key});

  @override
  State<AddUserAccount> createState() => _AddUserAccountState();
}

class _AddUserAccountState extends State<AddUserAccount> {
  String result = "";

  final TextEditingController _serverEditingController =
      TextEditingController();
  final TextEditingController _usernameEditingController =
      TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(context) => Scaffold(
        appBar: AppBar(
          title: Text("Add user account"),
        ),
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: AutofillGroup(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.web),
                      labelText: "Subsonic server URL",
                      hintText: "https//example.com",
                    ),
                    autofillHints: const [AutofillHints.url],
                    validator: (value) {
                      try {
                        if (value == null) {
                          return "Cannot be empty";
                        }
                        Uri uri = Uri.parse(value);
                        if (!uri.hasScheme) {
                          return "Specify the scheme (http/https)";
                        }
                        if (uri.host == "") {
                          return "Specify the domain (e.g. example.com)";
                        }
                        return null;
                      } catch (FormatException) {
                        return "Not a valid URL";
                      }
                    },
                    controller: _serverEditingController,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: "Username",
                    ),
                    controller: _usernameEditingController,
                    autofillHints: const [AutofillHints.username],
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.password),
                      labelText: "Password",
                    ),
                    obscureText: true,
                    controller: _passwordEditingController,
                    autofillHints: const [AutofillHints.password],
                  ),
                  Text(result),
                  ElevatedButton(
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        _formKey.currentState!.save();

                        Uri server = Uri.parse(_serverEditingController.text);
                        String username = _usernameEditingController.text;
                        String password = _passwordEditingController.text;

                        SubsonicClient client = SubsonicClient(
                            serverUrl: server,
                            username: username,
                            password: password);
                        var pingResult = await client.ping();
                        setState(() {
                          if (pingResult is SubsonicApiSuccess) {
                            result =
                                "Success! API version: ${pingResult.version}";
                          } else if (pingResult is SubsonicApiError) {
                            result =
                                "Failure: ${pingResult.message} (code ${pingResult.code})";
                          } else if (pingResult is SubsonicError) {
                            result = "Error: ${pingResult.error}";
                          } else {
                            throw Error();
                          }
                        });
                      },
                      child: Text("Save"))
                ],
              ),
            ),
          ),
        ),
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
    return Drawer(
        child: Column(children: [
      DrawerHeader(
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
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
          leading: Icon(Icons.person),
          title: Text("Accounts"),
          onTap: () {
            Navigator.pushNamed(context, '/user-accounts');
          }),
      const ListTile(
        leading: Icon(Icons.settings),
        title: Text("Settings"),
      )
    ]));
  }
}
