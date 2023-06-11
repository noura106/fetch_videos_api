import 'package:dartz/dartz.dart';
import 'package:fetch_videos_api/core/core/error/failures.dart';
import 'package:fetch_videos_api/features/videos/data/model/video_model.dart';
import 'package:fetch_videos_api/features/videos/domain/entities/video_entity.dart';

abstract class VideosRepository {
  Future<Either<Failure, List<VideoModel>>> getAllVideos();
}
