import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_project/data/models/song/song.dart';
import 'package:spotify_project/domain/entities/song/song.dart';
import 'package:spotify_project/domain/usecases/song/is_favourite_song.dart';
import 'package:spotify_project/service_locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getPlayList();
  Future<Either> addOrRemoveFavourite(String songId);
  Future<bool> isFavouriteSong(String songId);
  Future<Either> getUserFavouriteSongs();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];

      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          // .limit(3)
          .get();

      for (var e in data.docs) {
        var songModel = SongModel.fromMap(e.data());
        bool isFavourite =
            await sl<IsFavouriteSongUsecase>().call(params: e.reference.id);
        songModel = songModel.copyWith(
            isFavourite: isFavourite, songId: e.reference.id);
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } on FirebaseException catch (e) {
      log(e.toString());
      return const Left('An erroe occured, please try again');
    }
  }

  @override
  Future<Either> getPlayList() async {
    try {
      List<SongEntity> songs = [];

      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .get();

      for (var e in data.docs) {
        var songModel = SongModel.fromMap(e.data());
        bool isFavourite =
            await sl<IsFavouriteSongUsecase>().call(params: e.reference.id);
        songModel = songModel.copyWith(
            isFavourite: isFavourite, songId: e.reference.id);
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } on FirebaseException catch (e) {
      log(e.toString());
      return const Left('An erroe occured, please try again');
    }
  }

  @override
  Future<Either> addOrRemoveFavourite(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFavourite;

      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favouriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favourites')
          .where('songId', isEqualTo: songId)
          .get();
      if (favouriteSongs.docs.isNotEmpty) {
        await favouriteSongs.docs.first.reference.delete();
        isFavourite = false;
      } else {
        await firebaseFirestore
            .collection('Users')
            .doc(uId)
            .collection('Favourites')
            .add({"songId": songId, "addedDate": Timestamp.now()});

        isFavourite = true;
      }
      return Right(isFavourite);
    } catch (e) {
      return const Left('An error occured.');
    }
  }

  @override
  Future<bool> isFavouriteSong(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favouriteSongs = await firebaseFirestore
          .collection('User')
          .doc(uId)
          .collection('Favourites')
          .where('songId', isEqualTo: songId)
          .get();

      return favouriteSongs.docs.isNotEmpty;
    } catch (e) {
      log('An error occurred.');
      return false;
    }
  }

  @override
  Future<Either> getUserFavouriteSongs() async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final List<SongEntity> favouriteSongs = [];

      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favouriteSnapshot = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favourites')
          .get();

      for (var el in favouriteSnapshot.docs) {
        String songId = (el.data() as Map<String, dynamic>)['songId'];
        var song =
            await firebaseFirestore.collection('Songs').doc(songId).get();
        SongModel songModel = SongModel.fromMap(song.data()!);
        songModel = songModel.copyWith(isFavourite: true, songId: songId);
        favouriteSongs.add(songModel.toEntity());
      }

      return Right(favouriteSongs);
    } catch (e) {
      return const Left('An error occurred.');
    }
  }
}
