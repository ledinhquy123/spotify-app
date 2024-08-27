import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/domain/usecases/song/get_news_songs.dart';
import 'package:spotify_project/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify_project/service_locator.dart';

class NewsSongsCubit extends Cubit<NewsSongsState> {
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs() async {
    var returnedSongs = await sl<GetNewsSongsUseCase>().call();

    returnedSongs.fold((l) {
      emit(NewsSongsLoadFailure());
    }, (r) {
      emit(NewsSongsLoaded(songs: r));
    });
  }
}
