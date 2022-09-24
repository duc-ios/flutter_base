import 'dart:ui';

abstract class ILangRepository {
  Locale getDeviceLocale();
  Locale getLocale();
  Future setLocale(Locale val);
}
