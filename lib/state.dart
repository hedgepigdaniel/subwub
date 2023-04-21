import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'state.freezed.dart';
part 'state.g.dart';

@freezed
class AppState with _$AppState {
  const factory AppState({
    required IMap<String, UserAccount> userAccounts,
    required String? currentUserAccount,
  }) = _AppState;

  factory AppState.fromJson(Map<String, Object?> json) =>
      _$AppStateFromJson(json);
}

const AppState initialState =
    AppState(userAccounts: IMapConst({}), currentUserAccount: null);

@freezed
class UserAccount with _$UserAccount {
  const UserAccount._();

  const factory UserAccount({
    required String serverUrl,
    required String username,
    required String password,
  }) = _UserAccount;

  String get key => Uri.parse(serverUrl).replace(userInfo: username).toString();

  factory UserAccount.fromJson(Map<String, Object?> json) =>
      _$UserAccountFromJson(json);
}
