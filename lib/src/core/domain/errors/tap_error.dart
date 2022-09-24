import 'package:freezed_annotation/freezed_annotation.dart';

part 'tap_error.freezed.dart';

@freezed
class TapError with _$TapError {
  const factory TapError.tooManyTaps() = _TooManyTap;
}
