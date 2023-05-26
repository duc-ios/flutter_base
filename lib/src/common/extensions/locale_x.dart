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

  bool isEqualTo(Locale compare) {
    if (this == compare) {
      return true;
    }
    if (scriptCode?.isNotEmpty == true && scriptCode == compare.scriptCode) {
      return true;
    }
    if ((scriptCode?.isEmpty == true || compare.scriptCode?.isEmpty == true)
        && countryCode?.isNotEmpty == true
        && countryCode == compare.countryCode
    ) {
      return true;
    }
    return false;
  }

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
      return _getPlatformLanguage(components);
    } else if (components.isNotEmpty) {
      return Locale(components[0]);
    } else {
      return LocaleX.fallbackLocale;
    }
  }

  Locale _getPlatformLanguage(List<String> components) {
    if (ZHStringSupport.zhTraditionalString.contains(this)) {
      return const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant');
    }
    if (ZHStringSupport.zhSimplifiedString.contains(this)) {
      return const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans');
    }
    return Locale.fromSubtags(
        languageCode: components[0], scriptCode: components[1]);
  }
}

class ZHStringSupport {
  static const zhTraditionalString = [
    'zh_Hant', 'zh_Hant_TW', 'zh_Hant_HK', 'zh_TW', 'zh_HK', 'zh_CHT'
  ];

  static const zhSimplifiedString = [
    'zh_Hans', 'zh_Hans_CN', 'zh_CN', 'zh_CHS', 'zh_SG'
  ];
}
