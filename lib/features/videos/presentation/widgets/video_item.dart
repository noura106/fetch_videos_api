import 'package:cached_network_image/cached_network_image.dart';
import 'package:fetch_videos_api/core/core/app_theme.dart';
import 'package:fetch_videos_api/core/core/assets.dart';
import 'package:fetch_videos_api/core/core/font_manager.dart';

import 'package:fetch_videos_api/features/videos/presentation/screens/video_details.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/ui_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VideoItem extends StatelessWidget {
  final String id;
  final String nameOfVideos;
  final int secondNumber;
  final String urlImage;

  const VideoItem(
      {Key? key,
      required this.id,
      required this.nameOfVideos,
      required this.secondNumber,
      required this.urlImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
                child: Hero(
                    tag: id,
                    child: urlImage.isNotEmpty
                        ? CachedNetworkImage(
                            imageUrl: urlImage,
                            placeholder: (context, url) => Image.asset(
                              'assets/images/place_holder.png',
                              fit: BoxFit.cover,
                              gaplessPlayback: true,
                            ),
                            errorWidget: (context, url, error) =>
                                Image.asset('assets/images/place_holder.png'),
                          )
                        : Image.asset('assets/images/place_holder.png')),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Assets.videoIcon),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 120,
                          child: UiText(
                              title: nameOfVideos,
                              textStyle: FontManager.namesOfVideos.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700)),
                        ),
                        UiText(
                            title: '3H AGO',
                            textStyle: FontManager.miniName
                                .copyWith(color: Colors.black))
                      ],
                    ),
                    const SizedBox(
                      width: 120,
                    ),
                    Container(
                      width: 70,
                      height: 30,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: UiText(
                            title: '$secondNumber sec',
                            textStyle: FontManager.numbers
                                .copyWith(color: Colors.black)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
