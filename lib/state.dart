import 'package:built_value/built_value.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';

part 'state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  static Serializer<AppState> get serializer => _$appStateSerializer;

  BuiltMap<UserAccountKey, UserAccountValue> get userAccounts;

  static AppState initial() => AppState((builder) {
        builder.userAccounts.addAll({});
      });

  factory AppState([void Function(AppStateBuilder) updates]) = _$AppState;
  AppState._();
}

abstract class UserAccountKey
    implements Built<UserAccountKey, UserAccountKeyBuilder> {
  static Serializer<UserAccountKey> get serializer =>
      _$userAccountKeySerializer;

  String get serverUrl;
  String get username;

  factory UserAccountKey([void Function(UserAccountKeyBuilder) updates]) =
      _$UserAccountKey;
  UserAccountKey._();
}

abstract class UserAccountValue
    implements Built<UserAccountValue, UserAccountValueBuilder> {
  static Serializer<UserAccountValue> get serializer =>
      _$userAccountValueSerializer;

  String get password;

  factory UserAccountValue([void Function(UserAccountValueBuilder) updates]) =
      _$UserAccountValue;
  UserAccountValue._();
}
