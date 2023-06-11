import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'video_player_state.dart';

class VideoPlayerCubit extends Cubit<VideoPlayerState> {
  VideoPlayerCubit() : super(VideoPlayerInitial());
  /// the state of the current video if its playing or not
  bool playing = false;

  /// to show the app bar and the icon of the play and pause a the bottom widget that used for seeking the video
  bool clicked = true;

  @override
  Future<void> close() async {
    super.close();
    clicked = true;
    playing = false;
  }

  void play() {
    playing = true;
    emit(VideoPlayerInitial());
    emit(VideoPlayerLoaded());
  }

  void pause() {
    playing = false;
    emit(VideoPlayerInitial());
    emit(VideoPlayerLoaded());
  }

  void click() {
    clicked = !clicked;

    emit(VideoPlayerInitial());
    emit(VideoPlayerLoaded());
  }

  void playTheVideo() {
    emit(VideoPlayerInitial());
    emit(VideoPlayerLoaded());
  }
}
