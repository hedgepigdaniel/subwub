import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:subwub/state.dart';

IMap<String, UserState> selectStateByUser(AppState state) =>
    state.stateByUserId;
