import 'package:reselect/reselect.dart';
import 'package:subwub/selectors/select-current-user-state.dart';

var makeSelectAlbumIdsByArtistId = (String artistId) => createSelector1(
      selectCurrentUserState,
      (currentUserState) {
        if (currentUserState == null) {
          return null;
        }
        var albumIds = currentUserState.albumIdsByArtistId.get(artistId);
        if (albumIds == null) {
          return null;
        }
        return albumIds;
      },
    );
