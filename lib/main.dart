import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';
import 'package:subwub/state.dart';

import '../reducer.dart';

import 'widgets/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final persistor = Persistor(
    debug: true,
    storage: FlutterStorage(),
    serializer: JsonSerializer(
      (json) => json == null ? null : AppState.fromJson(json),
    ),
  );

  final loadedInitialState = (await persistor.load()) ?? initialState;

  final store = Store<AppState>(
    reducer,
    initialState: loadedInitialState,
    middleware: [
      persistor.createMiddleware(),
      LoggingMiddleware.printer(),
    ],
  );

  runApp(App(store: store));
}
