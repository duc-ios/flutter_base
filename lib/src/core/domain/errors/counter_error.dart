import 'package:freezed_annotation/freezed_annotation.dart';

part 'counter_error.freezed.dart';

@freezed
class CounterError with _$CounterError {
  const factory CounterError.mustbeLessThan5() = _MustbeLessThan5;
  const factory CounterError.mustGreaterThan0() = _MustGreaterThan0;
}
