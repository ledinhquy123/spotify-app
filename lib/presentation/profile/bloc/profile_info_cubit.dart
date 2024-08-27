import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_project/domain/usecases/auth/get_user.dart';
import 'package:spotify_project/presentation/profile/bloc/profile_info_state.dart';
import 'package:spotify_project/service_locator.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    final result = await sl<GetUserUsecase>().call();

    result.fold((l) {
      emit(ProfileInfoFailure());
    }, (r) {
      emit(ProfileInfoLoaded(userEntity: r));
    });
  }
}
