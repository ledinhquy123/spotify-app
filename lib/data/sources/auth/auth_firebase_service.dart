// ignore_for_file: unused_local_variable

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_project/core/configs/constants/app_urls.dart';
import 'package:spotify_project/data/models/auth/create_user_req.dart';
import 'package:spotify_project/data/models/auth/signin_user_req.dart';
import 'package:spotify_project/data/models/auth/user.dart';
import 'package:spotify_project/domain/entities/auth/user.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq createUserReq);
  Future<Either> signin(SigninUserReq signinUserReq);
  Future<Either> getUser();
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either> signin(SigninUserReq signinUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signinUserReq.email, password: signinUserReq.password);
      return const Right('Signin was successful');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'Not user found for that email';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password for that user';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: createUserReq.email, password: createUserReq.password);

      FirebaseFirestore.instance.collection('Users').doc(data.user!.uid).set({
        'name': createUserReq.fullName,
        'email': data.user?.email,
      });

      return const Right('Signup was successful');
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> getUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      DocumentSnapshot user = await firebaseFirestore
          .collection('Users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();

      UserModel userModel =
          UserModel.fromMap(user.data() as Map<String, dynamic>);
      userModel = userModel.copyWith(
          fullName: (user.data() as Map<String, dynamic>)['name'],
          imageURL: firebaseAuth.currentUser?.photoURL ?? AppUrls.defaultImage);
      UserEntity userEntity = userModel.toEntity();

      return Right(userEntity);
    } on FirebaseException catch (e) {
      log(e.toString());
      return const Left('An error occurred.');
    }
  }
}
