part of 'counter_bloc.dart';

@freezed
class CounterState with _$CounterState {
  const factory CounterState.loading() = _Loading;
  const factory CounterState.failure(String error) = _Failure;
  const factory CounterState.value(int value) = _Value;
}
