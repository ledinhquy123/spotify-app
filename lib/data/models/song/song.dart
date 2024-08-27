// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:spotify_project/domain/entities/song/song.dart';

class SongModel {
  String? songId;
  String? title;
  String? artist;
  num? duration;
  Timestamp? releaseDate;
  bool? isFavourite;

  SongModel({
    required this.songId,
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.isFavourite,
  });

  SongModel copyWith(
      {String? songId,
      String? title,
      String? artist,
      num? duration,
      Timestamp? releaseDate,
      bool? isFavourite}) {
    return SongModel(
        songId: songId ?? this.songId,
        title: title ?? this.title,
        artist: artist ?? this.artist,
        duration: duration ?? this.duration,
        releaseDate: releaseDate ?? this.releaseDate,
        isFavourite: isFavourite ?? this.isFavourite);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'songId': songId,
      'title': title,
      'artist': artist,
      'duration': duration,
      'releaseDate': releaseDate,
      'isFavourite': isFavourite
    };
  }

  factory SongModel.fromMap(Map<String, dynamic> map) {
    return SongModel(
        // songId: '',
        songId: map['songId'] != null ? map['songId'] as String : null,
        title: map['title'] as String,
        artist: map['artist'] as String,
        duration: map['duration'] as num,
        releaseDate: map['releaseDate'] as Timestamp,
        isFavourite: map['isFavourite'] != null ? map['isFavourite'] as bool : null);
  }

  String toJson() => json.encode(toMap());

  factory SongModel.fromJson(String source) =>
      SongModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
        songId: songId!,
        title: title!,
        artist: artist!,
        duration: duration!,
        releaseDate: releaseDate!,
        isFavourite: isFavourite!);
  }
}
