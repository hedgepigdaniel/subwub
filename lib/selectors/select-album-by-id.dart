import 'package:reselect/reselect.dart';
import 'package:subwub/selectors/select-current-user-state.dart';

var makeSelectAlbumById = (String albumId) => createSelector1(
      selectCurrentUserState,
      (currentUserState) {
        if (currentUserState == null) {
          return null;
        }
        var album = currentUserState.albumsById.get(albumId);
        if (album == null) {
          return null;
        }
        return album;
      },
    );
