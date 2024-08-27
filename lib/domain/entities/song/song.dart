import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String songId;
  final String title;
  final String artist;
  final num duration;
  final Timestamp releaseDate;
  final bool isFavourite;

  SongEntity({
    required this.songId,
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavourite,
  });
}
