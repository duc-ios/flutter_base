import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppLocalization extends StatelessWidget {
  AppLocalization({Key? key, required this.child}) : super(key: key);

  final Widget child;

  final supportedLocales = [
    const Locale('en'),
    const Locale('zh', 'Hant'),
    const Locale('zh', 'Hans')
  ];

  Locale get fallbackLocale {
    const fallbackLocale = Locale('zh', 'Hant');
    final components = Platform.localeName.split('_');
    final locale =
        Locale(components[0], (components.length > 1) ? components[1] : null);
    if (locale.languageCode == 'en') {
      return const Locale('en');
    } else if (supportedLocales.contains(locale)) {
      return locale;
    } else {
      return fallbackLocale;
    }
  }

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
        supportedLocales: supportedLocales,
        fallbackLocale: fallbackLocale,
        saveLocale: true,
        path: 'assets/i18n',
        child: child);
  }
}
