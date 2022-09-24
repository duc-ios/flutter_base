import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'tap_cubit.freezed.dart';
part 'tap_state.dart';

class TapCubit extends Cubit<TapState> {
  TapCubit() : super(const _Value(0));

  var _value = 0;

  void tap() {
    _value += 1;
    emit(_Value(_value));
    if (_value > 10) {
      return emit(const _Failure('Too many tap!'));
    }
  }
}
