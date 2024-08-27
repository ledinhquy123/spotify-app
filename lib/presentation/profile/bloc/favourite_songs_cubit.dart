import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/domain/usecases/song/get_user_favourite_songs.dart';
import 'package:spotify_project/presentation/profile/bloc/favourite_songs_state.dart';
import 'package:spotify_project/service_locator.dart';

class FavouriteSongsCubit extends Cubit<FavouriteSongsState> {
  FavouriteSongsCubit() : super(FavouriteSongsLoading());

  List<SongEntity> favouriteSongs = [];
  Future<void> getUserFavouriteSongs() async {
    final result = await sl<GetUserFavouriteSongsUsecase>().call();

    result.fold((l) {
      emit(FavouriteSongsFailure());
    }, (r) {
      favouriteSongs = r;
      emit(FavouriteSongsLoaded(favouriteSongs: favouriteSongs));
    });
  }

  void removeSong(int index) {
    favouriteSongs.removeAt(index);
    emit(FavouriteSongsLoaded(favouriteSongs: favouriteSongs));
  }
}
