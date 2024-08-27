import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/helpers/is_dark_mode.dart';
import 'package:spotify_project/core/configs/constants/app_urls.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/presentation/home/bloc/news_songs_cubit.dart';
import 'package:spotify_project/presentation/home/bloc/news_songs_state.dart';
import 'package:spotify_project/presentation/song_player/pages/song_player_page.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    final kW = MediaQuery.of(context).size.width;
    final kH = MediaQuery.of(context).size.height;

    return BlocProvider(
      create: (_) => NewsSongsCubit()..getNewsSongs(),
      child: BlocBuilder<NewsSongsCubit, NewsSongsState>(
        builder: (context, state) {
          if (state is NewsSongsLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }
          if (state is NewsSongsLoaded) {
            return _songs(context, state.songs, kW, kH);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _songs(
      BuildContext context, List<SongEntity> songs, double kW, double kH) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final song = songs[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SongPlayerPage(song: song)));
            },
            child: SizedBox(
              width: kW * 0.35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  '${AppUrls.coverFirestorage}${song.artist} - ${song.title}.png?${AppUrls.altMedia}'))),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 40,
                          height: 40,
                          transform: Matrix4.translationValues(-10, 10, 0),
                          decoration: BoxDecoration(
                              color: context.isDarkMode
                                  ? AppColors.darkGrey
                                  : const Color(0xffE6E6E6),
                              shape: BoxShape.circle),
                          child: Icon(Icons.play_arrow_rounded,
                              color: context.isDarkMode
                                  ? const Color(0xff959595)
                                  : const Color(0xff555555)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: kH * 0.02),
                  Text(
                    song.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: kH * 0.005),
                  Text(
                    song.artist,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(
              width: kW * 0.05,
            ),
        itemCount: songs.length);
  }
}
