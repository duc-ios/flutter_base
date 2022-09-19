import 'dart:io';
import 'dart:ui';

import '../../../generated/l10n.dart';
import '../utils/hive_utils.dart';

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

  String get fullLanguageCode =>
      [languageCode, scriptCode].where((element) => element != null).join('_');

  static List<Locale> get supportedLocales =>
      List<Locale>.from(S.delegate.supportedLocales)
        ..sort((l, r) {
          return l.languageCode.compareTo(r.languageCode);
        });

  static Locale get deviceLocale => Platform.localeName.toLocale;

  static Locale get currentLocale {
    final String lang = box.get(BoxKeys.lang) ?? Platform.localeName;
    final locale = lang.toLocale;
    if (S.delegate.isSupported(locale)) {
      return locale;
    } else {
      return LocaleX.fallbackLocale;
    }
  }

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
