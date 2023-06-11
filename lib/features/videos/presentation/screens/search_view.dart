import 'package:fetch_videos_api/core/core/font_manager.dart';
import 'package:fetch_videos_api/features/videos/presentation/blocs/videos_bloc/videos_bloc.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/ui_text.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/video_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchVideosView extends StatelessWidget {
  const SearchVideosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideosBloc, VideosState>(
      builder: (context, state) {
        if(state is SearchEnded){
          return VideosListWidget(videos: context.read<VideosBloc>().allVideos);
        }
        return context.read<VideosBloc>().searchVideoResult.isNotEmpty
            ? VideosListWidget(
                videos: context.read<VideosBloc>().searchVideoResult)
            : Center(
                child: UiText(
                  title: 'No Result Found',
                  textStyle:
                      FontManager.headerTitle1.copyWith(color: Colors.black),
                ),
              );
      },
    );
  }
}
