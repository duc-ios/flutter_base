import 'dart:io';
import 'dart:ui';

import '../../../../generated/l10n.dart';
import '../../../common/extensions/locale_x.dart';
import '../../../common/utils/storage.dart';
import '../../domain/interfaces/lang_interface.dart';

class LangRepository implements LangInterface {
  @override
  Locale getDeviceLocale() => Platform.localeName.toLocale;

  @override
  Locale getLocale() {
    final String lang = Storage.lang ?? Platform.localeName;
    final locale = lang.toLocale;
    if (S.delegate.isSupported(locale)) {
      return locale;
    } else {
      return LocaleX.fallbackLocale;
    }
  }

  @override
  Future setLocale(Locale val) async =>
      await Storage.setLang(val.fullLanguageCode);
}
