
import 'package:fetch_videos_api/core/core/app_theme.dart';
import 'package:fetch_videos_api/core/core/font_manager.dart';
import 'package:fetch_videos_api/features/videos/presentation/widgets/ui_text.dart';
import 'package:flutter/material.dart';

class HomeMainScreenAppBar extends StatelessWidget {
  const HomeMainScreenAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FontManager.textScaleOfDevice = MediaQuery.of(context).textScaleFactor;
    return AppBar(
      backgroundColor: Colors.white,
      leadingWidth: MediaQuery.of(context).size.width * 0.5,
      elevation: 0.0,
      key: const Key("HomeMainScreenAppBar"),
      centerTitle: false,
      leading: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/images/avatar_1.png'),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          UiText(
              title: 'Welcome, nour!',
              textStyle: FontManager.headerTitle2.copyWith(color: Colors.black))
        ],
      ),
    );
  }
}
