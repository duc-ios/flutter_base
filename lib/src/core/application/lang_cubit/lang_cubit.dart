import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../common/extensions/locale_x.dart';
import '../../../common/mixin/safe_bloc_base.dart';
import '../../../common/utils/logger.dart';
import '../../domain/interfaces/lang_repository.dart';

@singleton
class LangCubit extends Cubit<Locale> with SafeBlocBase {
  LangCubit(
    this._repository,
  ) : super(_repository.getLocale());

  final LangRepository _repository;

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
