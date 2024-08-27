import 'package:get_it/get_it.dart';
import 'package:spotify_project/data/repository/auth/auth_repository_impl.dart';
import 'package:spotify_project/data/repository/song/song_repository_impl.dart';
import 'package:spotify_project/data/sources/auth/auth_firebase_service.dart';
import 'package:spotify_project/data/sources/song/song_firebase_service.dart';
import 'package:spotify_project/domain/repository/auth/auth.dart';
import 'package:spotify_project/domain/repository/song/song.dart';
import 'package:spotify_project/domain/usecases/auth/get_user.dart';
import 'package:spotify_project/domain/usecases/auth/signin.dart';
import 'package:spotify_project/domain/usecases/auth/signup.dart';
import 'package:spotify_project/domain/usecases/song/add_or_remove_favourite_song.dart';
import 'package:spotify_project/domain/usecases/song/get_news_songs.dart';
import 'package:spotify_project/domain/usecases/song/get_play_list.dart';
import 'package:spotify_project/domain/usecases/song/get_user_favourite_songs.dart';
import 'package:spotify_project/domain/usecases/song/is_favourite_song.dart';

final sl = GetIt.instance;

Future<void> initizeDependensies() async {
  //TODO Authen
  sl.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());

  sl.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  sl.registerSingleton<SignupUsecase>(SignupUsecase());

  sl.registerSingleton<SignInUseCase>(SignInUseCase());

  //TODO Songs
  sl.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());

  sl.registerSingleton<SongRepository>(SongRepositoryImpl());

  sl.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());

  sl.registerSingleton<GetPlayListUseCase>(GetPlayListUseCase());

  sl.registerSingleton<AddOrRemoveFavouriteSongUsecase>(
      AddOrRemoveFavouriteSongUsecase());

  sl.registerSingleton<IsFavouriteSongUsecase>(IsFavouriteSongUsecase());

  sl.registerSingleton<GetUserUsecase>(GetUserUsecase());

  sl.registerSingleton<GetUserFavouriteSongsUsecase>(GetUserFavouriteSongsUsecase());
}
