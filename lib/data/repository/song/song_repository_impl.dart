import 'package:dartz/dartz.dart';
import 'package:spotify_project/data/sources/song/song_firebase_service.dart';
import 'package:spotify_project/domain/repository/song/song.dart';
import 'package:spotify_project/service_locator.dart';

class SongRepositoryImpl extends SongRepository {
  @override
  Future<Either> getNewsSongs() async {
    return await sl<SongFirebaseService>().getNewsSongs();
  }

  @override
  Future<Either> getPlayList() async {
    return await sl<SongFirebaseService>().getPlayList();
  }
  
  @override
  Future<Either> addOrRemoveFavourite(String songId) async {
    return await sl<SongFirebaseService>().addOrRemoveFavourite(songId);
  }
  
  @override
  Future<bool> isFavouriteSong(String songId) async {
    return await sl<SongFirebaseService>().isFavouriteSong(songId);
  }
  
  @override
  Future<Either> getUserFavouriteSongs() async {
    return await sl<SongFirebaseService>().getUserFavouriteSongs();
  }
}
