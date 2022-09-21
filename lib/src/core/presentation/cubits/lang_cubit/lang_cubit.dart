import 'dart:ui';

import 'package:bloc/bloc.dart';

import '../../../../common/extensions/locale_x.dart';
import '../../../../common/utils/logger.dart';
import '../../../application/lang_service.dart';

class LangCubit extends Cubit<Locale> {
  LangCubit(
    this._langService,
  ) : super(_langService.getLocale());

  final LangService _langService;

  void setLocale(Locale val) async {
    try {
      await _langService.setLocale(val);
      logger.d('currentLocale - ${val.fullLanguageCode}');
      emit(val);
    } catch (error) {
      logger.e(error);
    }
  }
}
