part of 'videos_bloc.dart';

@immutable
abstract class VideosState {}

class VideosInitial extends VideosState {}

class LoadingVideosState extends VideosState {}

class LoadedVideosState extends VideosState {
  final List<VideoModel> videos;

  LoadedVideosState({required this.videos});
}

class ErrorVideosState extends VideosState {
  final String message;

  ErrorVideosState({required this.message});
}


/// states for search
class SearchInVideosLoading extends VideosState {}

class SearchInVideosLoaded extends VideosState {}

class SearchStarted extends VideosState {}

class SearchEnded extends VideosState {}

class SearchControllerCleared extends VideosState {}
