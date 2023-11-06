import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../generated/l10n.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

@freezed
class ApiError with _$ApiError implements Exception {
  factory ApiError(int? code, String message) = _ApiError;
  factory ApiError.server({int? code, required String message}) = _Server;
  factory ApiError.network({int? code, required String message}) = _Network;
  factory ApiError.internal(String message) = _Internal;
  factory ApiError.cancelled() = _Cancelled;
  factory ApiError.unexpected() = _Unexpected;
  factory ApiError.unauthorized(String message) = _Unauthorized;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  ApiError._();

  String get message {
    return maybeWhen(
      orElse: () => S.current.error_unexpected,
      (code, message) => message,
      server: (code, message) => message,
      internal: (message) => message,
      network: (_, message) => message,
      unauthorized: (message) => message,
    );
  }

  String get title => maybeWhen(
        (code, message) => S.current.error,
        unauthorized: (message) => S.current.error_unauthorized,
        network: (code, __) => code == HttpStatus.internalServerError
            ? S.current.error_internal_server
            : S.current.error,
        orElse: () => S.current.error,
      );
}
