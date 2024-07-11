import 'dart:ui';

abstract class LangRepository {
  Locale getDeviceLocale();
  Locale getLocale();
  Future setLocale(Locale val);
}
