import 'package:dartz/dartz.dart';
import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/domain/repository/song/song.dart';
import 'package:spotify_project/service_locator.dart';

class AddOrRemoveFavouriteSongUsecase implements Usecase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    return await sl<SongRepository>().addOrRemoveFavourite(params!);
  }
}
