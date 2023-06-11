import 'package:fetch_videos_api/core/core/font_manager.dart';
import 'package:fetch_videos_api/features/videos/data/model/video_model.dart';
import 'package:fetch_videos_api/features/videos/presentation/blocs/video_player_cubit/video_player_cubit.dart';
import 'package:fetch_videos_api/features/videos/presentation/blocs/videos_bloc/videos_bloc.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/grid_view_of_photos.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/rating_widget.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/ui_text.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoDetails extends StatelessWidget {
  final VideoModel video;

  const VideoDetails({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: VideoPlayerWidget(
                  url: 'http://139.99.68.128:5500/uploads/${video.videoUrl}'),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: SizedBox(
                        width: 120,
                        child: UiText(
                            title: video.name,
                            textStyle: FontManager.namesOfVideos.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w700)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: UiText(
                          title: video.createdAt.substring(0, 4),
                          textStyle: FontManager.numbers.copyWith(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700)),
                    ),
                    UiText(
                        title: ' | +${video.viewerCount}',
                        textStyle: FontManager.numbers.copyWith(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700)),
                    const SizedBox(
                      width: 5,
                    ),
                    RatingWidget(rateOfVideo: video.rate),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: UiText(
                        title: video.description,
                        textStyle: FontManager.description
                            .copyWith(color: Colors.black),
                        align: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: GridViewItems(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
