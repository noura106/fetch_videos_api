import 'package:dartz/dartz.dart';
import 'package:fetch_videos_api/core/core/error/failures.dart';
import 'package:fetch_videos_api/features/videos/data/model/video_model.dart';
import 'package:fetch_videos_api/features/videos/domain/entities/video_entity.dart';
import 'package:fetch_videos_api/features/videos/domain/repositories/videos_repository.dart';

class GetAllVideosUseCase  {
  final VideosRepository repository;

  GetAllVideosUseCase(this.repository);

  Future<Either<Failure, List<VideoModel>>> call() async {
    return await repository.getAllVideos();
  }
}