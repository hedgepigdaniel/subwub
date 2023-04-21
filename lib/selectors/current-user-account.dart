import 'package:subwub/state.dart';

UserAccount? selectCurrentUserAccount(AppState state) {
  String? currentUserAccount = state.currentUserAccount;
  if (currentUserAccount != null) {
    return state.userAccounts[currentUserAccount];
  } else {
    return null;
  }
}
