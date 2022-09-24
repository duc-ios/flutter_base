part of 'tap_cubit.dart';

@freezed
class TapState with _$TapState {
  const factory TapState.failure(String error) = _Failure;
  const factory TapState.value(int value) = _Value;
}
