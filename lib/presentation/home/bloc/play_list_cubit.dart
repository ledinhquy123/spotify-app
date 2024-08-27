import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/domain/usecases/song/get_play_list.dart';
import 'package:spotify_project/presentation/home/bloc/play_list_state.dart';
import 'package:spotify_project/service_locator.dart';

class PlayListCubit extends Cubit<PlayListState> {
  PlayListCubit() : super(PlayListLoading());

  Future<void> getPlayList() async {
    var returnedSongs = await sl<GetPlayListUseCase>().call();

    returnedSongs.fold((l) {
      emit(PlayListLoadFailure());
    }, (r) {
      emit(PlayListLoaded(songs: r));
    });
  }
}
