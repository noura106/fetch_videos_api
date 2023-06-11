import 'package:fetch_videos_api/core/core/assets.dart';
import 'package:flutter/material.dart';

class GridViewItems extends StatelessWidget {
  const GridViewItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: photos.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(photos[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    );
  }
}

List photos = [
  Assets.photo1,
  Assets.photo2,
  Assets.photo3,
  Assets.photo4,
  Assets.photo5,
  Assets.photo6,
  Assets.photo7,
  Assets.photo8,
  Assets.photo9,
  Assets.photo10,
  Assets.photo11,
  Assets.photo12,
];
