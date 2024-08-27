// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:spotify_project/common/bloc/facourite_button/favaurite_button_state.dart';
import 'package:spotify_project/common/bloc/facourite_button/favourite_button_cubit.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/domain/entities/song/song.dart';

class FavouriteButton extends StatelessWidget {
  const FavouriteButton({
    Key? key,
    required this.song,
    this.onPressed,
  }) : super(key: key);
  final SongEntity song;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FavouriteButtonCubit(),
        child: BlocBuilder<FavouriteButtonCubit, FavouriteButtonState>(
            builder: (context, state) {
          if (state is FavouriteButtonInitial) {
            return IconButton(
                onPressed: () {
                  context
                      .read<FavouriteButtonCubit>()
                      .favouriteButtonUpdated(song.songId);
                  if (onPressed != null) {
                    onPressed!();
                  }
                },
                icon: Icon(
                    song.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_outline_outlined,
                    size: 25,
                    color: AppColors.grey));
          }

          if (state is FavouriteButtonUpdated) {
            return IconButton(
                onPressed: () {
                  context
                      .read<FavouriteButtonCubit>()
                      .favouriteButtonUpdated(song.songId);
                },
                icon: Icon(
                    state.isFavourite
                        ? Icons.favorite
                        : Icons.favorite_outline_outlined,
                    size: 25,
                    color: AppColors.grey));
          }

          return const SizedBox.shrink();
        }));
  }
}
