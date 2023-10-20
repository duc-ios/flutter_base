import 'package:flutter/material.dart';

import 'text_theme/default_text_theme.dart';
import 'text_theme_interfaces.dart';

typedef AppThemeFilters = TextThemeFactory? Function(
    Map<Locale, TextThemeFactory>);

class TextThemeFactoryProvider {
  final Map<Locale, TextThemeFactory> mapper;

  TextThemeFactoryProvider._(this.mapper);

  factory TextThemeFactoryProvider.of({
    required Map<Locale, TextThemeFactory> mapper,
  }) => TextThemeFactoryProvider._(mapper);

  TextThemeFactory find(
    Locale locale, {
    AppThemeFilters? filter,
  }) {
    final filtering = filter ?? (mapper) => mapper[locale];
    return filtering(mapper) ?? DefaultTextTheme();
  }
}
