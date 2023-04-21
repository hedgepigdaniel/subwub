import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required IMap<UserAccountKey, UserAccountValue> userAccounts,
  }) = _AppState;

  factory AppState.fromJson(Map<String, Object?> json) =>
      _$AppStateFromJson(json);
}

@freezed
class UserAccountKey with _$UserAccountKey {
  const factory UserAccountKey({
    required String serverUrl,
    required String username,
  }) = _UserAccountKey;

  factory UserAccountKey.fromJson(Map<String, Object?> json) =>
      _$UserAccountKeyFromJson(json);
}

@freezed
class UserAccountValue with _$UserAccountValue {
  const factory UserAccountValue({
    required String password,
  }) = _UserAccountValue;

  factory UserAccountValue.fromJson(Map<String, Object?> json) =>
      _$UserAccountValueFromJson(json);
}
