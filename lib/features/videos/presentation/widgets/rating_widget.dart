import 'package:fetch_videos_api/core/core/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RatingWidget extends StatelessWidget {
  final String rateOfVideo;

  const RatingWidget({Key? key, required this.rateOfVideo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      unratedColor: Color.fromRGBO(217, 217, 217, 1),
      itemSize: 20,
      initialRating: 3,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      glow: false,
      ignoreGestures: true,
      itemCount: 5,
      itemPadding: EdgeInsets.symmetric(horizontal: 3),
      itemBuilder: (context, _) {
        double rate = double.parse(rateOfVideo);
        if (rate >= _ + 1) {
          return SvgPicture.asset(
            Assets.starColored,
          );
        } else {
          return SvgPicture.asset(
            Assets.starEmpty,
          );
        }
      },
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
