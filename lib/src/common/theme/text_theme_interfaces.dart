import 'package:flutter/material.dart';

abstract class TextThemeFactory {
  TextTheme create();

  TextStyle get light;
  TextStyle get regular;
  TextStyle get medium;
  TextStyle get semiBold;
  TextStyle get bold;

  TextStyle get displayLarge;
  TextStyle get displayMedium;
  TextStyle get displaySmall;

  TextStyle get headlineLarge;
  TextStyle get headlineMedium;
  TextStyle get headlineSmall;

  TextStyle get titleLarge;
  TextStyle get titleMedium;
  TextStyle get titleSmall;

  TextStyle get bodyLarge;
  TextStyle get bodyMedium;
  TextStyle get bodySmall;

  TextStyle get labelLarge;
  TextStyle get labelMedium;
  TextStyle get labelSmall;

  TextStyle get caption;
}
