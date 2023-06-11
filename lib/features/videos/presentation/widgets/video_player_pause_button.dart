import 'package:fetch_videos_api/core/core/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VideoPlayerPlayPauseButton extends StatelessWidget {
  const VideoPlayerPlayPauseButton({
    Key? key,
    required this.onTap,
    required this.clicked,
    required this.playing, required this.onTapPlayBack, required this.onTapArrow,
  }) : super(key: key);
  final Function() onTap;
  final Function()onTapPlayBack;
  final Function() onTapArrow;
  final bool clicked;
  final bool playing;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: clicked ? 1 : 0,
      duration: const Duration(milliseconds: 200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            onTap: onTapPlayBack,
            child: SvgPicture.asset(
             Assets.playBack
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            onTap: onTap,
            child: Container(
              width: 35,
              height:35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black
              ),
              child: Center(
                child: Icon(
                  playing? Icons.pause: Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
            )
          ),
          InkWell(
            splashColor: Colors.transparent,
            onTap: onTapArrow,
            child: SvgPicture.asset(
                Assets.playArrow
            ),
          ),
        ],
      ),
    );
  }
}