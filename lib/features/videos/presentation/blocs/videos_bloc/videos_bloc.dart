import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fetch_videos_api/core/core/error/failures.dart';
import 'package:fetch_videos_api/core/core/strings/apis_urls.dart';
import 'package:fetch_videos_api/core/core/strings/failures.dart';
import 'package:fetch_videos_api/features/videos/data/model/video_model.dart';
import 'package:fetch_videos_api/features/videos/domain/use_cases/get_all_videos.dart';
import 'package:file/src/interface/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

part 'videos_event.dart';

part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final GetAllVideosUseCase getAllVideosUseCase;
  String fullUrlOfEachVideo = '';
  String fullUrlOfEachVideoCoverImage = '';
  List<String> allVideosUrls = [];
  List<String> allImagesUrls = [];
  final TextEditingController searchTextEditingController =
      TextEditingController();
  List<VideoModel> allVideos = [];
  List<VideoModel> searchVideoResult = [];

  /// 0 means contacts view
  /// 1 means search contacts view
  int stackIndex = 0;
  final FocusNode focusNode = FocusNode();
  TextDirection searchTextDirection = TextDirection.ltr;

  VideosBloc({required this.getAllVideosUseCase}) : super(VideosInitial()) {
    on<GetAllVideosEvent>((event, emit) async {
      emit(LoadingVideosState());
      final videos = await getAllVideosUseCase();

      videos.fold((l) {
        emit(ErrorVideosState(message: _mapFailureToMessage(l)));
      }, (videos) async {
        allVideos.addAll(videos);
        final urlsOfVideos = videos.map((r) => r.videoUrl);
        final urlsOfImages = videos.map((r) => r.coverImageUrl);
        List<String> videoArrayToInc = [];
        for (var url in urlsOfVideos) {
          fullUrlOfEachVideo = baseUrlVideo + url;
          videoArrayToInc.add(fullUrlOfEachVideo);
        }
        allVideosUrls.addAll(videoArrayToInc);
        print(allVideosUrls.length);
        List<String> imageArrayToInc = [];

        for (var image in urlsOfImages) {
          fullUrlOfEachVideoCoverImage = baseUrlImage + image;
          imageArrayToInc.add(fullUrlOfEachVideoCoverImage);
        }
        allImagesUrls.addAll(imageArrayToInc);
        print(allImagesUrls.length);
        emit(LoadedVideosState(videos: videos));
      });
    });
    on<StartSearchInVideosEvent>((event, emit) async {
      focusNode.requestFocus();
      stackIndex = 1;
      searchVideoResult
        ..clear()
        ..addAll(allVideos);
      searchTextEditingController.clear();
      searchTextDirection = TextDirection.ltr;
      emit(SearchStarted());
    });
    on<EndSearchInVideosEvent>((event, emit) async {
      stackIndex = 0;
      searchVideoResult.clear();
      focusNode.unfocus();
      searchTextEditingController.clear();
      searchTextDirection = TextDirection.ltr;
      emit(SearchEnded());
    });
    on<ClearSearchController>((event, emit) async {
      searchTextEditingController.clear();
      focusNode.requestFocus();
      searchVideoResult
        ..clear()
        ..addAll(allVideos);
      searchTextDirection = TextDirection.ltr;
      emit(SearchControllerCleared());
    });
    on<SearchFromVideosEventsListEvent>((event, emit) async {
      emit(SearchInVideosLoading());
      await Future.delayed(const Duration(milliseconds: 200));
      List<VideoModel> searchedList = [];
      searchedList.addAll(allVideos);
      if (searchTextEditingController.text.trim().isNotEmpty) {
        stackIndex = 1;
        emit(SearchInVideosLoading());
        searchVideoResult.clear();
        print("gdsagsda");
        for (var video in searchedList) {
          print("adsgdsga");
          if ((video.name.toLowerCase().contains(
                      searchTextEditingController.text.toLowerCase()) ??
                  false) ||
              (video.description.toLowerCase().contains(
                      searchTextEditingController.text.toLowerCase()) ??
                  false)) {
            print("dsagdsa");
            searchVideoResult.add(video);
          }
        }
      } else {
        searchTextDirection = TextDirection.ltr;
        searchVideoResult
          ..clear()
          ..addAll(searchedList);
      }
      emit(SearchInVideosLoaded());
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case EmptyCacheFailure:
        return EMPTY_CACHE_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
