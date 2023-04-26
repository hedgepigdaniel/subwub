import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:subwub/actions.dart';

import './state.dart';

AppState reducer(AppState state, dynamic actionDynamic) {
  AppAction action = actionDynamic;
  switch (action) {
    case UpsertUserAccountAction():
      UserAccount user = UserAccount(
        password: action.password,
        serverUrl: action.serverUrl.toString(),
        username: action.username,
      );
      return state.copyWith(
        stateByUserId: state.stateByUserId.add(
          user.key,
          UserState(
            userAccount: user,
          ),
        ),
        currentUserAccount: user.key,
      );

    case SubsonicGetArtistsResponseAction(userAccount: var userAccount):
      UserState? userState = state.stateByUserId.get(userAccount);
      if (userState == null) {
        throw Error();
      }
      return state.copyWith(
        stateByUserId: state.stateByUserId.add(
          userAccount,
          userState.copyWith(
            sortedArtistIds: action.index.index.fold(
              IList(const []),
              (value, element) =>
                  value.addAll(element.artist.map((artist) => artist.id)),
            ),
            artistsById: action.index.index.fold(
              IMap(const {}),
              (value, element) => value.addAll(element.artist.fold(
                  IMap(const {}),
                  (subValue, artist) => subValue.add(artist.id, artist))),
            ),
          ),
        ),
      );
    case SubsonicGetArtistResponseAction(userAccount: var userAccount):
      UserState? userState = state.stateByUserId.get(userAccount);
      if (userState == null) {
        throw Error();
      }
      return state.copyWith(
        stateByUserId: state.stateByUserId.add(
          userAccount,
          userState.copyWith(
            albumIdsByArtistId: userState.albumIdsByArtistId.add(
              action.artist.artist.id,
              IList(action.artist.artist.album.map((album) => album.id)),
            ),
            albumsById: userState.albumsById.addAll(
              action.artist.artist.album.fold(
                const IMapConst({}),
                (currentValue, album) => currentValue.add(album.id, album),
              ),
            ),
          ),
        ),
      );
  }
}
