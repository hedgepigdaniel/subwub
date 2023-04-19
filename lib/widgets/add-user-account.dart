import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../actions.dart';
import '../state.dart';
import '../subsonic/subsonic.dart';

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
          title: const Text("Add user account"),
        ),
        body: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: AutofillGroup(
            child: Padding(
              padding: const EdgeInsets.all(16),
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
                  StoreConnector<AppState, Dispatch>(
                    converter: convertDispatch,
                    builder: (context, dispatch) => ElevatedButton(
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          _formKey.currentState!.save();

                          Uri server = Uri.parse(_serverEditingController.text);
                          String username = _usernameEditingController.text;
                          String password = _passwordEditingController.text;

                          dispatch(UpsertUserAccount(
                            serverUrl: server,
                            username: username,
                            password: password,
                          ));

                          SubsonicClient client = SubsonicClient(
                              serverUrl: server,
                              username: username,
                              password: password);
                          var pingResult = await client.ping();
                          setState(() {
                            switch (pingResult) {
                              case SubsonicApiSuccess(version: var version):
                                result = "Success! API version: $version";
                              case SubsonicApiError(
                                  message: var message,
                                  code: var code
                                ):
                                result = "Failure: $message (code $code)";
                              case SubsonicError(error: var error):
                                result = "Error: $error";
                            }
                          });
                        },
                        child: const Text("Save")),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
