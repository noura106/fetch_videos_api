import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:fetch_videos_api/core/core/error/exeptions.dart';
import 'package:fetch_videos_api/features/videos/data/model/video_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
abstract class VideoLocalDataSource {
  Future<List<VideoModel>> getCachedVideos();
  Future<Unit> cacheVideos(List<VideoModel> videoModel);
}

const CACHED_POSTS = "CACHED_POSTS";

class VideoLocalDataSourceImpl implements VideoLocalDataSource {
  final SharedPreferences sharedPreferences;

  VideoLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cacheVideos(List<VideoModel> postModels) {
    List postModelsToJson = postModels
        .map<Map<String, dynamic>>((postModel) => postModel.toJson())
        .toList();
    sharedPreferences.setString(CACHED_POSTS, json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<VideoModel>> getCachedVideos() {
    final jsonString = sharedPreferences.getString(CACHED_POSTS);
    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<VideoModel> jsonToVideoModels = decodeJsonData
          .map<VideoModel>((jsonPostModel) => VideoModel.fromJson(jsonPostModel))
          .toList();
      return Future.value(jsonToVideoModels);
    } else {
      throw EmptyCacheException();
    }
  }
}