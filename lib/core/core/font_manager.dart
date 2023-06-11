import 'package:flutter/material.dart';

class FontManager {
  /// text scale of device
  static double _textScale = 1;

  static get textScaleOfDevice => _textScale;

  static set textScaleOfDevice(value) => _textScale = value;

  /// Fonts Family which will be used in whole app
  static const poppins = 'Poppins';

  /// ********************FONT SIZES******************///
  static double scale = textScaleOfDevice;

  static double s7 = 7.5 * scale;
  static double s8 = 8 * scale;

  static double s9 = 9 * scale;

  static double s10 = 10 * scale;

  static double s11 = 11 * scale;

  static double s12 = 12 * scale;

  static double s13 = 13 * scale;
  static double s14 = 14 * scale;
  static double s15 = 15 * scale;

  static double s16 = 16 * scale;

  static double s18 = 18 * scale;
  static double s20 = 20 * scale;

  static double s24 = 24 * scale;

  static double s48 = 48 * scale;
  static const TextStyle mainTextStyle = TextStyle(
    fontFamily: poppins,
    decoration: TextDecoration.none,
    letterSpacing: 0,
    height: 1.2,
  );

  static TextStyle get headerTitle1 => mainTextStyle.copyWith(
        fontSize: s18,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get headerTitle2 => mainTextStyle.copyWith(
        fontSize: s15,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get namesOfVideos => mainTextStyle.copyWith(
        fontSize: s18,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get miniName => mainTextStyle.copyWith(
        fontSize: s14,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get inputTextField => mainTextStyle.copyWith(
    fontSize: s15,
    fontWeight: FontWeight.w500,
  );
  static TextStyle get numbers => mainTextStyle.copyWith(
    fontSize: s13,
    fontWeight: FontWeight.w500,
  );
  static TextStyle get description => mainTextStyle.copyWith(
    fontSize: s14,
    fontWeight: FontWeight.w500,
  );
  static TextStyle get btnText => mainTextStyle.copyWith(
    fontSize: s15,
    fontWeight: FontWeight.w500,
  );
}
