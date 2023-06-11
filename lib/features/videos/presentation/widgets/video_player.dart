import 'package:cached_video_player/cached_video_player.dart';
import 'package:fetch_videos_api/core/core/assets.dart';
import 'package:fetch_videos_api/core/core/font_manager.dart';
import 'package:fetch_videos_api/features/videos/presentation/blocs/video_player_cubit/video_player_cubit.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/full_screen_view.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/ui_text.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/video_player_pause_button.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/video_player_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String url;
  bool isFullScreenView;

   VideoPlayerWidget({Key? key, required this.url,this.isFullScreenView=false}) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late CachedVideoPlayerController controller;

  /// to convert the pause icon to play icon so the user can play the video again
  bool hasReachTheEndOfTheVideo = false;

  @override
  void initState() {
    controller = CachedVideoPlayerController.network(widget.url)
      ..addListener(() {
        context.read<VideoPlayerCubit>().playTheVideo();
        if (controller.value.position == controller.value.duration &&
            !hasReachTheEndOfTheVideo) {
          context.read<VideoPlayerCubit>().pause();
          hasReachTheEndOfTheVideo = true;
        } else if (controller.value.position != controller.value.duration) {
          hasReachTheEndOfTheVideo = false;
        }
      })
      ..initialize().then((_) {
        context.read<VideoPlayerCubit>().pause();
        controller.pause();
      });
    super.initState();
  }

  @override
  void dispose() async {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final videoBloc = context.read<VideoPlayerCubit>();
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Stack(alignment: Alignment.center, children: [
        InkWell(
          onTap: () {
            videoBloc.click();
          },
          child: BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
            builder: (context, state) {
              return AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: CachedVideoPlayer(controller));
            },
          ),
        ),
        Positioned(
          top: 50,
          left: 0,
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  Assets.backIcon,
                  width: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: UiText(
                      title: 'Back',
                      textStyle:
                          FontManager.btnText.copyWith(color: Colors.white)),
                )
              ],
            ),
          ),
        ),
        BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
          builder: (context, state) {
            return VideoPlayerPlayPauseButton(
              onTapPlayBack: () {
                controller.seekTo(Duration(
                    seconds: controller.value.position.inSeconds - 10));
              },
              onTapArrow: () {
                controller.seekTo(Duration(seconds: 10));
              },
              onTap: () {
                if (videoBloc.clicked) {
                  if (!videoBloc.playing) {
                    videoBloc.play();
                    controller.play();
                  } else {
                    videoBloc.pause();
                    controller.pause();
                  }
                }
              },
              clicked: videoBloc.clicked,
              playing: videoBloc.playing,
            );
          },
        ),
        BlocBuilder<VideoPlayerCubit, VideoPlayerState>(
          builder: (context, state) {
            return Positioned(
              bottom: 47,
              left: 5,
              right: 5,
              child: Row(
                children: [
                  Expanded(
                    child: VideoPlayerProgressWidget(
                      isClicked: videoBloc.clicked,
                      videoPlayerController: controller,
                    ),
                  ),
                  if(!widget.isFullScreenView)
                  InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FullScreenViewer(
                                tag: '',
                                child: VideoPlayerWidget(
                                  isFullScreenView: true,
                                    url:
                                        widget.url))));
                      },
                      child: SvgPicture.asset(Assets.fullScreen)),
                ],
              ),
            );
          },
        ),
      ]),
    );
  }
}
