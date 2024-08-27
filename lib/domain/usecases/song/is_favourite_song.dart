import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/domain/repository/song/song.dart';
import 'package:spotify_project/service_locator.dart';

class IsFavouriteSongUsecase implements Usecase<bool, String> {
  @override
  Future<bool> call({String? params}) async {
    return await sl<SongRepository>().isFavouriteSong(params!);
  }
}