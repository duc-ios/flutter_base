part of 'tap_cubit.dart';

@freezed
class TapState with _$TapState {
  const factory TapState.failure(Failure failure) = _Failure;
  const factory TapState.value(int value) = _Value;
}
