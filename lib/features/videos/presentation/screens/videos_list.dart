
import 'package:fetch_videos_api/core/core/assets.dart';
import 'package:fetch_videos_api/core/core/font_manager.dart';
import 'package:fetch_videos_api/core/core/widegts/loading_widget.dart';
import 'package:fetch_videos_api/features/videos/presentation/blocs/videos_bloc/videos_bloc.dart';
import 'package:fetch_videos_api/features/videos/presentation/screens/search_view.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/home_man_screen_app_bar.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/message_display_widget.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/search_text_field.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/ui_text.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/video_item.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/video_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VideosListScreen extends StatelessWidget {
  const VideosListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.25;
    final searchController = TextEditingController();
    return WillPopScope(
      onWillPop: () {
        if (context.read<VideosBloc>().stackIndex == 1) {
          context.read<VideosBloc>().add(EndSearchInVideosEvent());
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height),
          child: Column(
            children: [
              const HomeMainScreenAppBar(),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5, left: 10),
                          child: UiText(
                            maxLines: 2,
                            align: TextAlign.left,
                            title: 'Find The Best Educational Cources Here!',
                            textStyle: FontManager.headerTitle1
                                .copyWith(color: Colors.black),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 52,
                    margin: EdgeInsets.only(left: 10, right: 50),
                    child: SearchTextField(
                      textInputAction: TextInputAction.done,
                      textDirection:
                          context.read<VideosBloc>().searchTextDirection,
                      focusNode: context.read<VideosBloc>().focusNode,
                      maxLines: 1,
                      searchText: 'search for cources',
                      controller: context
                          .read<VideosBloc>()
                          .searchTextEditingController,
                      suffixIcon: InkWell(
                          onTap: () {
                            context
                                .read<VideosBloc>()
                                .add(StartSearchInVideosEvent());
                          },
                          child: SvgPicture.asset(Assets.searchIcon)),
                      onTap: () {
                        context
                            .read<VideosBloc>()
                            .add(StartSearchInVideosEvent());
                      },
                      onChange: (val) {
                        context
                            .read<VideosBloc>()
                            .add(SearchFromVideosEventsListEvent());
                      },
                      hintStyle: FontManager.inputTextField.copyWith(
                        color: Colors.black,
                        fontSize: FontManager.s12,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        body: context.read<VideosBloc>().stackIndex == 0
            ? BlocBuilder<VideosBloc, VideosState>(
                builder: (context, state) {
                  if (state is LoadingVideosState) {
                    return LoadingWidget();
                  } else if (state is LoadedVideosState) {
                    return  VideosListWidget(videos: state.videos);
                  } else if (state is ErrorVideosState) {
                    return MessageDisplayWidget(message: state.message);
                  }
                  return LoadingWidget();
                },
              )
            : SearchVideosView(),
      ),
    );
  }
}
