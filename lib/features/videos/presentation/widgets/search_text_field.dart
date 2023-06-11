import 'dart:io';

import 'package:fetch_videos_api/core/core/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchTextField extends StatelessWidget {
  /// a widget you can put at the lead

  /// controller
  final TextEditingController controller;

  /// text field on Tap function
  final GestureTapCallback? onTap;

  /// search text input
  final String searchText;

  /// TextStyle for the hint style
  final TextStyle hintStyle;

  /// text field on change function
  final Function(String)? onChange;

  final FocusNode? focusNode;

  final TextDirection? textDirection;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final Widget? suffixIcon;

  const SearchTextField({
    Key? key,
    required this.controller,
    required this.onTap,
    required this.searchText,
    required this.hintStyle,
    this.onChange,
    this.focusNode,
    this.textDirection,
    this.textInputAction,
    this.maxLines,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: FontManager.inputTextField.copyWith(color: Colors.black),
      textDirection: textDirection,
      textInputAction: textInputAction,
      maxLines: maxLines,
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
        enabled: true,
        filled: true,
        fillColor: Colors.grey.withOpacity(0.3),
        suffixIcon: suffixIcon != null
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: suffixIcon,
              )
            : null,
        hintText: searchText,
        hintStyle: Platform.isIOS == false
            ? hintStyle
            : FontManager.inputTextField.copyWith(
                color: Colors.black38,
                fontWeight: FontWeight.w400,
                fontSize: FontManager.s10),
      ),
      onChanged: onChange,
      onTap: onTap,
    );
  }
}
