import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/common/appbar/app_bar.dart';
import 'package:spotify_project/common/helpers/is_dark_mode.dart';
import 'package:spotify_project/common/widgets/favourite_button/favourite_button.dart';
import 'package:spotify_project/core/configs/constants/app_urls.dart';
import 'package:spotify_project/core/configs/theme/app_colors.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/presentation/song_player/bloc/song_player_cubit.dart';
import 'package:spotify_project/presentation/song_player/bloc/song_player_state.dart';

class SongPlayerPage extends StatelessWidget {
  const SongPlayerPage({super.key, required this.song});
  final SongEntity song;

  @override
  Widget build(BuildContext context) {
    final kW = MediaQuery.of(context).size.width;
    final kH = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: BasicAppBar(
        title: const Text(
          'Now playing',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        action: IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert,
                color: context.isDarkMode
                    ? const Color(0xffDDDDDD)
                    : const Color(0xff7D7D7D))),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()
          ..loadSong(
              '${AppUrls.songFirestorage}${song.title}.mp3?${AppUrls.altMedia}'),
        child: SingleChildScrollView(
          padding:
              EdgeInsets.symmetric(vertical: kH * 0.03, horizontal: kW * 0.05),
          child: Column(
            children: [
              _songCover(context, kW, kH),
              SizedBox(height: kH * 0.02),
              _songDetail(kH),
              _songPlayer(context, kW, kH)
            ],
          ),
        ),
      ),
    );
  }

  Widget _songCover(BuildContext context, double kW, double kH) {
    return Container(
      height: kH * 0.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(
                  '${AppUrls.coverFirestorage}${song.artist} - ${song.title}.png?${AppUrls.altMedia}'))),
    );
  }

  Widget _songDetail(double kH) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(song.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            SizedBox(height: kH * 0.001),
            Text(song.artist,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w400))
          ],
        ),
        FavouriteButton(song: song)
      ],
    );
  }

  Widget _songPlayer(BuildContext context, double kW, double kH) {
    return BlocBuilder<SongPlayerCubit, SongPlayerState>(
        builder: (context, state) {
      if (state is SongPlayerLoading) {
        return const Center(
          child: CircularProgressIndicator(
            color: AppColors.primary,
          ),
        );
      }
      if (state is SongPlayerLoaded) {
        return Column(
          children: [
            Slider(
                activeColor: context.isDarkMode
                    ? AppColors.grey
                    : const Color(0xff5C5C5C),
                thumbColor: context.isDarkMode
                    ? AppColors.grey
                    : const Color(0xff5C5C5C),
                value: context
                    .read<SongPlayerCubit>()
                    .songPosition
                    .inSeconds
                    .toDouble(),
                min: 0.0,
                max: context
                    .read<SongPlayerCubit>()
                    .songDuration
                    .inSeconds
                    .toDouble(),
                onChanged: (position) {}),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDuration(context.read<SongPlayerCubit>().songPosition),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: context.isDarkMode
                          ? const Color(0xff878787)
                          : const Color(0xff404040)),
                ),
                Text(
                  formatDuration(context.read<SongPlayerCubit>().songDuration),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: context.isDarkMode
                          ? const Color(0xff878787)
                          : const Color(0xff404040)),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                context.read<SongPlayerCubit>().playOrPauseSong();
              },
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                    color: AppColors.primary, shape: BoxShape.circle),
                child: Icon(
                    context.read<SongPlayerCubit>().audioPlayer.playing
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white),
              ),
            )
          ],
        );
      }
      return const SizedBox.shrink();
    });
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(
        60); // Get remainder of duration (example: 1h2m is 62 minutes, so take 2)
    final seconds =
        duration.inSeconds.remainder(60); // Consider above but get seconds
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}
