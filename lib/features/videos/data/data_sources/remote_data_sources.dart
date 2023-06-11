import 'dart:convert';

import 'package:fetch_videos_api/core/core/error/exeptions.dart';
import 'package:fetch_videos_api/features/videos/data/model/video_model.dart';
import 'package:http/http.dart' as http;

abstract class VideoRemoteDataSource {
  Future<List<VideoModel>> getAllVideos();
}

class VideoRemoteDataSourceImpl implements VideoRemoteDataSource {

  @override
  Future<List<VideoModel>> getAllVideos(
      [int pageNumber = 6, int pageSize = 10]) async {
    String BASE_URL =
        'http://139.99.68.128:5500/api/videos?pageNumber=$pageNumber&pageSize=$pageSize';
    final response = await http.get(
      Uri.parse(BASE_URL),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final  decodedJson = json.decode(response.body);
      final videos = List<Map<String, dynamic>>.from(decodedJson['data']);
      final List<VideoModel> videoModels = videos
          .map<VideoModel>(
              (jsonPostModel) => VideoModel.fromJson(jsonPostModel))
          .toList();

      return videoModels;
    } else {
      throw ServerException();
    }
  }
}
