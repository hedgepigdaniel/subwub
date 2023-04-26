import 'package:reselect/reselect.dart';
import 'package:subwub/selectors/select-current-user-state.dart';

var makeSelectArtistById = (String artistId) => createSelector1(
      selectCurrentUserState,
      (currentUserState) {
        if (currentUserState == null) {
          return null;
        }
        var artist = currentUserState.artistsById.get(artistId);
        if (artist == null) {
          return null;
        }
        return artist;
      },
    );
