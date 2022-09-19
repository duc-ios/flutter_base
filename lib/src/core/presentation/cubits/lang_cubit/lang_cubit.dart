import 'dart:ui';

import 'package:bloc/bloc.dart';

import '../../../../common/extensions/locale_x.dart';
import '../../../../common/utils/hive_utils.dart';
import '../../../../common/utils/logger.dart';

class LangCubit extends Cubit<Locale> {
  LangCubit() : super(LocaleX.currentLocale);

  void setLocale(Locale val) async {
    emit(val);
    logger.d(val.fullLanguageCode);
    await box.put(BoxKeys.lang, val.fullLanguageCode);
  }
}
