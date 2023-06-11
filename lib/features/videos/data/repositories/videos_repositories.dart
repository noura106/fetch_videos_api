import 'package:dartz/dartz.dart';
import 'package:fetch_videos_api/core/core/error/exeptions.dart';
import 'package:fetch_videos_api/core/core/error/failures.dart';
import 'package:fetch_videos_api/core/core/network/network_info.dart';
import 'package:fetch_videos_api/features/videos/data/data_sources/local_data_sources.dart';
import 'package:fetch_videos_api/features/videos/data/data_sources/remote_data_sources.dart';
import 'package:fetch_videos_api/features/videos/data/model/video_model.dart';
import 'package:fetch_videos_api/features/videos/domain/entities/video_entity.dart';
import 'package:fetch_videos_api/features/videos/domain/repositories/videos_repository.dart';

class VideosRepositoryImpl implements VideosRepository {
  final VideoRemoteDataSource remoteDataSource;
  final VideoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  VideosRepositoryImpl({required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo});

  @override
  Future<Either<Failure, List<VideoModel>>> getAllVideos() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteVideos = await remoteDataSource.getAllVideos();
        localDataSource.cacheVideos(remoteVideos);
        return Right(remoteVideos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localVideos = await localDataSource.getCachedVideos();
        return Right(localVideos);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }
}