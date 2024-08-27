import 'package:dartz/dartz.dart';

abstract class SongRepository {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavourite(String songId);
  Future<bool> isFavouriteSong(String songId);
  Future<Either> getUserFavouriteSongs();
}