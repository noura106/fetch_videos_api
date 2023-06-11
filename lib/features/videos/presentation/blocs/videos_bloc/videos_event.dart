part of 'videos_bloc.dart';

@immutable
abstract class VideosEvent {}

class GetAllVideosEvent extends VideosEvent {}

/// events for search
class SearchFromVideosEventsListEvent extends VideosEvent {
  SearchFromVideosEventsListEvent();
}

class StartSearchInVideosEvent extends VideosEvent {
  StartSearchInVideosEvent();
}

class EndSearchInVideosEvent extends VideosEvent {}

class ClearSearchController extends VideosEvent {
  ClearSearchController();
}
