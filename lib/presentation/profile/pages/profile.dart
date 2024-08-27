import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/appbar/app_bar.dart';
import 'package:spotify_project/common/helpers/is_dark_mode.dart';
import 'package:spotify_project/common/widgets/favourite_button/favourite_button.dart';
import 'package:spotify_project/core/configs/constants/app_urls.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/presentation/profile/bloc/favourite_songs_cubit.dart';
import 'package:spotify_project/presentation/profile/bloc/favourite_songs_state.dart';
import 'package:spotify_project/presentation/profile/bloc/profile_info_cubit.dart';
import 'package:spotify_project/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotify_project/presentation/song_player/pages/song_player_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final kW = MediaQuery.of(context).size.width;
    final kH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: BasicAppBar(
        backgroundColor: context.isDarkMode ? AppColors.darkGrey : Colors.white,
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profileInfo(context, kW, kH),
          SizedBox(height: kH * 0.03),
          _favouriteSongs(context, kH, kW)
        ],
      ),
    );
  }

  Widget _profileInfo(BuildContext context, double kW, double kH) {
    return BlocProvider(
        create: (context) => ProfileInfoCubit()..getUser(),
        child: Container(
          height: kH * 0.25,
          width: kW,
          decoration: BoxDecoration(
              color: context.isDarkMode ? AppColors.darkGrey : Colors.white,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  bottomRight: Radius.circular(60))),
          child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
            builder: (context, state) {
              if (state is ProfileInfoLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              }
              if (state is ProfileInfoLoaded) {
                final userEntity = state.userEntity;
                return Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(userEntity.imageURL!))),
                    ),
                    SizedBox(height: kH * 0.015),
                    Text(
                      userEntity.email.toString(),
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: kH * 0.015),
                    Text(
                      userEntity.fullName.toString(),
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    )
                  ],
                );
              }
              if (state is ProfileInfoFailure) {
                return const Text('Please try again.');
              }
              return const SizedBox.expand();
            },
          ),
        ));
  }

  Widget _favouriteSongs(BuildContext context, double kH, double kW) {
    return BlocProvider(
      create: (context) => FavouriteSongsCubit()..getUserFavouriteSongs(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kH * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'FAVOURITE SONGS',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            SizedBox(height: kH * 0.02),
            BlocBuilder<FavouriteSongsCubit, FavouriteSongsState>(
                builder: (context, state) {
              if (state is FavouriteSongsLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primary,
                  ),
                );
              }
              if (state is FavouriteSongsLoaded) {
                return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final song = state.favouriteSongs[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SongPlayerPage(song: song)));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              '${AppUrls.coverFirestorage}${song.artist} - ${song.title}.png?${AppUrls.altMedia}'))),
                                ),
                                SizedBox(width: kW * 0.05),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      song.title,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      song.artist,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  song.duration.toString().replaceAll('.', ':'),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                                // SizedBox(width: kW * 0.02),
                                FavouriteButton(
                                  song: song,
                                  key: UniqueKey(),
                                  onPressed: () {
                                    context
                                        .read<FavouriteSongsCubit>()
                                        .removeSong(index);
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: kH * 0.015,
                        ),
                    itemCount: state.favouriteSongs.length);
              }

              if (state is FavouriteSongsFailure) {
                return const Text('Please try again.');
              }

              return const SizedBox.shrink();
            })
          ],
        ),
      ),
    );
  }
}
