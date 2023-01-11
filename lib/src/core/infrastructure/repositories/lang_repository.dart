import 'dart:io';
import 'dart:ui';

import 'package:injectable/injectable.dart';

import '../../../../generated/l10n.dart';
import '../../../common/extensions/locale_x.dart';
import '../../domain/interfaces/lang_repository_interface.dart';
import '../datasources/local/storage.dart';

@LazySingleton(as: ILangRepository)
class LangRepository implements ILangRepository {
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
