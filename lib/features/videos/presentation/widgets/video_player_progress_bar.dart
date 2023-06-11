
import 'package:fetch_videos_api/core/core/font_manager.dart';
import 'package:fetch_videos_api/core/core/utils.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/full_screen_view.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/ui_text.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:cached_video_player/cached_video_player.dart';

class VideoPlayerProgressWidget extends StatelessWidget {
  final bool isClicked;

  const VideoPlayerProgressWidget(
      {Key? key, required this.videoPlayerController, required this.isClicked})
      : super(key: key);
  final CachedVideoPlayerController videoPlayerController;

  @override
  Widget build(BuildContext context) {
    return isClicked
        ? SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 3),
                UiText(
                    title:
                        Utils.getDuration(videoPlayerController.value.position),
                    textStyle:
                        FontManager.numbers.copyWith(color: Colors.white)),
                SizedBox(width: 3),
                Expanded(
                  child: VideoProgressIndicator(
                    videoPlayerController,
                    allowScrubbing: true,
                    colors: const VideoProgressColors(
                        backgroundColor: Colors.black, playedColor: Colors.red),
                  ),
                ),
                SizedBox(width: 3),
                UiText(
                    title:
                        Utils.getDuration(videoPlayerController.value.duration),
                    textStyle:
                        FontManager.numbers.copyWith(color: Colors.white)),
                SizedBox(width: 3),

              ],
            ),
          )
        : Offstage();
  }
}
