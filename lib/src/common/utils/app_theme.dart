import 'package:flutter/material.dart';

import '../../../generated/colors.gen.dart';

class AppTheme {
  static TextTheme get textTheme => const TextTheme();

  static ThemeData themeData = ThemeData(
    primarySwatch: ColorName.materialPrimary,
    textTheme: textTheme,
  );
}
