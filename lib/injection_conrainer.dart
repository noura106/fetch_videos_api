
import 'package:fetch_videos_api/core/core/network/network_info.dart';
import 'package:fetch_videos_api/features/videos/data/data_sources/local_data_sources.dart';
import 'package:fetch_videos_api/features/videos/data/data_sources/remote_data_sources.dart';
import 'package:fetch_videos_api/features/videos/data/repositories/videos_repositories.dart';
import 'package:fetch_videos_api/features/videos/domain/repositories/videos_repository.dart';
import 'package:fetch_videos_api/features/videos/domain/use_cases/get_all_videos.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'features/videos/presentation/blocs/videos_bloc/videos_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - Videos

// Bloc

  sl.registerFactory(() => VideosBloc(getAllVideosUseCase: sl()));


// Usecases

  sl.registerLazySingleton(() => GetAllVideosUseCase(sl()));

// Repository

  sl.registerLazySingleton<VideosRepository>(() => VideosRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<VideoRemoteDataSource>(
          () => VideoRemoteDataSourceImpl());
  sl.registerLazySingleton<VideoLocalDataSource>(
          () => VideoLocalDataSourceImpl(sharedPreferences: sl()));

//! Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

//! External


  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}