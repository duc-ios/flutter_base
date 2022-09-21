import 'dart:ui';

import '../infrastructure/repositories/lang_repository.dart';

class LangService {
  final LangRepository _repository;

  LangService(this._repository);

  Locale getDeviceLocale() => _repository.getDeviceLocale();
  Locale getLocale() => _repository.getLocale();
  Future setLocale(Locale val) => _repository.setLocale(val);
}
