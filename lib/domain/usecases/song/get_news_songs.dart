import 'package:dartz/dartz.dart';
import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/domain/repository/song/song.dart';
import 'package:spotify_project/service_locator.dart';

class GetNewsSongsUseCase implements Usecase<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async {
    return await sl<SongRepository>().getNewsSongs();
  }
}