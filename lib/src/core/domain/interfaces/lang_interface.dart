import 'dart:ui';

abstract class LangInterface {
  Locale getDeviceLocale();
  Locale getLocale();
  Future setLocale(Locale val);
}
