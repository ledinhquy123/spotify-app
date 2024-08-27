import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/helpers/is_dark_mode.dart';
import 'package:spotify_project/common/widgets/favourite_button/favourite_button.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/presentation/home/bloc/play_list_cubit.dart';
import 'package:spotify_project/presentation/home/bloc/play_list_state.dart';
import 'package:spotify_project/presentation/song_player/pages/song_player_page.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    final kW = MediaQuery.of(context).size.width;
    final kH = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (_) => PlayListCubit()..getPlayList(),
      child:
          BlocBuilder<PlayListCubit, PlayListState>(builder: (context, state) {
        if (state is PlayListLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        }
        if (state is PlayListLoaded) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: kW * 0.07, vertical: kH * 0.04),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Playlist',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)),
                    Text('See More',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400))
                  ],
                ),
                SizedBox(height: kH * 0.03),
                _song(state.songs, kW, kH)
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  Widget _song(List<SongEntity> songs, double kW, double kH) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final song = songs[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SongPlayerPage(song: song)));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                          color: context.isDarkMode
                              ? const Color(0xff2C2C2C)
                              : const Color(0xffE6E6E6),
                          shape: BoxShape.circle),
                      child: Center(
                        child: Icon(
                          Icons.play_arrow_sharp,
                          color: context.isDarkMode
                              ? const Color(0xff959595)
                              : const Color(0xff555555),
                        ),
                      ),
                    ),
                    SizedBox(width: kW * 0.05),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(song.title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        SizedBox(height: kH * 0.01),
                        Text(song.artist,
                            style: const TextStyle(
                                fontSize: 12, fontWeight: FontWeight.w400))
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(song.duration.toString().replaceAll('.', ':')),
                    SizedBox(width: kW * 0.01),
                    FavouriteButton(song: song)
                  ],
                )
              ],
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(height: kH * 0.02),
        itemCount: songs.length);
  }
}
