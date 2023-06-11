
import 'package:flutter/material.dart';

class UiText extends StatelessWidget {
  final String title;
  final TextAlign align;
  final TextStyle textStyle;
  final int maxLines;
  UiText({Key? key, required this.title, this.align = TextAlign
      .left, required this.textStyle,this.maxLines=1 })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines:maxLines,
      title,
      textAlign: align,
      style: textStyle,

    );
  }
}
