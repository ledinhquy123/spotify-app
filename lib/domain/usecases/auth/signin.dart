import 'package:dartz/dartz.dart';
import 'package:spotify_project/core/usecase/usecase.dart';
import 'package:spotify_project/data/models/auth/signin_user_req.dart';
import 'package:spotify_project/domain/repository/auth/auth.dart';
import 'package:spotify_project/service_locator.dart';

class SignInUseCase implements Usecase<Either, SigninUserReq> {
  @override
  Future<Either> call({SigninUserReq? params}) async {
    return sl<AuthRepository>().signin(params!);
  }
}