import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:subwub/state.dart';
import 'package:subwub/subsonic/subsonic.dart';

IMap<String, IList<SubsonicArtist>> selectArtistsByUser(AppState state) =>
    state.artistsByUser;
