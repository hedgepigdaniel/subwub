import 'package:reselect/reselect.dart';
import 'package:subwub/selectors/artists-by-user.dart';
import 'package:subwub/selectors/current-user-account-key.dart';

var selectCurrentUserAccountArtists = createSelector2(
  selectCurrentUserAccountKey,
  selectArtistsByUser,
  (currentUserKey, artistsByUser) {
    if (currentUserKey != null) {
      return artistsByUser.get(currentUserKey);
    } else {
      return null;
    }
  },
);
