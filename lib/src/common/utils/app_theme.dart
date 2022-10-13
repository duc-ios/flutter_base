import 'package:flutter/material.dart';

import '../../../generated/colors.gen.dart';
import '../../../generated/fonts.gen.dart';

class AppTheme {
  static TextTheme get textTheme => const TextTheme();

  static ThemeData themeData = ThemeData(
    primarySwatch: ColorName.materialPrimary,
    textTheme: textTheme,
  );
}

extension TextThemeX on TextTheme {
  TextStyle get regular => const TextStyle(
        color: ColorName.black,
        fontSize: 16,
        fontFamily: FontFamily.roboto,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
      );

  TextStyle get medium => const TextStyle(
        color: ColorName.black,
        fontSize: 16,
        fontFamily: FontFamily.roboto,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
      );

  TextStyle get bold => const TextStyle(
        color: ColorName.black,
        fontSize: 16,
        fontFamily: FontFamily.roboto,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      );
}
