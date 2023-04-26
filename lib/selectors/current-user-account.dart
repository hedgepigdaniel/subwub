import 'package:reselect/reselect.dart';
import 'package:subwub/selectors/select-current-user-state.dart';

var selectCurrentUserAccount = createSelector1(
  selectCurrentUserState,
  (currentUserState) {
    if (currentUserState == null) {
      return null;
    }
    return currentUserState.userAccount;
  },
);
