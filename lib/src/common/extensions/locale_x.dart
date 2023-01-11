import 'dart:ui';

import '../../../generated/l10n.dart';

extension LocaleX on Locale {
  String get languageName {
    final languageName = toString();
    switch (languageName) {
      case 'en':
        return 'English';
      case 'zh_Hans':
        return '简体中文';
      case 'zh_Hant':
        return '繁體中文';
      default:
        return languageName;
    }
  }

  String get apiKey {
    final languageName = toString();
    switch (languageName) {
      case 'en':
        return 'en';
      case 'zh_Hans':
        return 'zh-cn';
      case 'zh_Hant':
        return 'zh-hk';
      default:
        return 'en';
    }
  }

  String get fullLanguageCode =>
      [languageCode, scriptCode].where((element) => element != null).join('_');

  static List<Locale> get supportedLocales =>
      List<Locale>.from(S.delegate.supportedLocales)
        ..sort((l, r) {
          return l.languageCode.compareTo(r.languageCode);
        });

  static Locale get fallbackLocale =>
      const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant');
}

extension StringLocale on String {
  Locale get toLocale {
    final components = split('_');
    if (components.length >= 2 && components[0] == 'zh') {
      return Locale.fromSubtags(
          languageCode: components[0], scriptCode: components[1]);
    } else if (components.isNotEmpty) {
      return Locale(components[0]);
    } else {
      return LocaleX.fallbackLocale;
    }
  }
}
