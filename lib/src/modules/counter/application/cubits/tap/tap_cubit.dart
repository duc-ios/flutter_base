import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:riverbloc/riverbloc.dart';

import '../../../../../common/mixin/safe_bloc_base.dart';
import '../../../../../common/utils/getit_utils.dart';

part 'tap_cubit.freezed.dart';
part 'tap_state.dart';

final tapProvider =
    AutoDisposeBlocProvider<TapCubit, TapState>((_) => getIt<TapCubit>());

@injectable
class TapCubit extends Cubit<TapState> with SafeBlocBase {
  TapCubit() : super(const _Value(0));

  var _value = 0;

  void tap() {
    _value += 1;
    emit(_Value(_value));
    if (_value > 10) {
      emit(const _Failure('Too many taps!'));
    }
  }
}
