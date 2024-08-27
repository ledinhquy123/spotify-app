import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/bloc/facourite_button/favaurite_button_state.dart';
import 'package:spotify_project/domain/usecases/song/add_or_remove_favourite_song.dart';
import 'package:spotify_project/service_locator.dart';

class FavouriteButtonCubit extends Cubit<FavouriteButtonState> {
  FavouriteButtonCubit() : super(FavouriteButtonInitial());

  void favouriteButtonUpdated(String songId) async {
    var result =
        await sl<AddOrRemoveFavouriteSongUsecase>().call(params: songId);

    result.fold((l) {
      log('An error occurred.');
    }, (r) {
      emit(FavouriteButtonUpdated(isFavourite: r));
    });
  }
}
