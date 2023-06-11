import 'package:fetch_videos_api/features/videos/data/model/video_model.dart';
import 'package:fetch_videos_api/features/videos/presentation/blocs/videos_bloc/videos_bloc.dart';
import 'package:fetch_videos_api/features/videos/presentation/screens/video_details.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/video_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideosListWidget extends StatelessWidget {
  final List<VideoModel> videos;

  const VideosListWidget({
    Key? key,
    required this.videos,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => VideoDetails(
                      video: videos[index],
                    )));
          },
          child: VideoItem(
              id: videos[index].id,
              nameOfVideos: videos[index].name,
              secondNumber: videos[index].secondNumber,
              urlImage: context.read<VideosBloc>().allImagesUrls[index]),
        );
      },
    );
  }
}
