import 'dart:ui';

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
}
