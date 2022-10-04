import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../generated/l10n.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

@freezed
class ApiError with _$ApiError {
  factory ApiError(int? code, String message) = _ApiError;
  factory ApiError.server({int? code, required String message}) = _Server;
  factory ApiError.network() = _Network;
  factory ApiError.internal(String message) = _Internal;
  factory ApiError.cancelled() = _Cancelled;
  factory ApiError.unexpected() = _Unexpected;
  factory ApiError.unauthorized() = _Unauthorized;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  ApiError._();

  String get message => maybeWhen(
        orElse: () => S.current.error_unexpected,
        (code, message) => message,
        server: (code, message) => message,
        network: () => S.current.error_network,
        internal: (message) => message,
      );
}
