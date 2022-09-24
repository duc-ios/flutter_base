import 'dart:ui';

import 'package:bloc/bloc.dart';

import '../../../../common/extensions/locale_x.dart';
import '../../../../common/utils/logger.dart';
import '../../../domain/interfaces/lang_repository_interface.dart';

class LangCubit extends Cubit<Locale> {
  LangCubit(
    this._repository,
  ) : super(_repository.getLocale());

  final ILangRepository _repository;

  void setLocale(Locale val) async {
    try {
      await _repository.setLocale(val);
      logger.d('currentLocale - ${val.fullLanguageCode}');
      emit(val);
    } catch (error) {
      logger.e(error);
    }
  }
}
