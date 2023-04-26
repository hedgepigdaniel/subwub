import 'package:reselect/reselect.dart';
import 'package:subwub/selectors/artists-by-user.dart';
import 'package:subwub/selectors/current-user-account-key.dart';

var selectCurrentUserState = createSelector2(
  selectCurrentUserAccountKey,
  selectStateByUser,
  (currentUserKey, stateByUser) {
    if (currentUserKey != null) {
      return stateByUser.get(currentUserKey);
    } else {
      return null;
    }
  },
);
