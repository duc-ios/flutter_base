import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../generated/l10n.dart';
import '../../../common/extensions/optional_x.dart';
import '../../../common/utils/app_environment.dart';

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
  factory ApiError.unauthorized() = _Unauthorized;
  factory ApiError.badRequest() = _BadRequest;

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  ApiError._();

  int? get code {
    return whenOrNull(
      (code, _) => code,
      server: (code, _) => code,
    );
  }

  String get message {
    return maybeWhen(
      orElse: () => S.current.error_unexpected,
      (code, message) => message,
      server: (code, message) => message,
      internal: (message) => message,
      network: (_, message) => message,
      unauthorized: () => S.current.error_unauthorized,
      badRequest: () => S.current.error_bad_request,
    );
  }

  String get title => maybeWhen(
        (code, message) => S.current.error,
        network: (code, __) => code == HttpStatus.internalServerError
            ? S.current.error_internal_server
            : S.current.error,
        orElse: () =>
            S.current.error +
            (AppEnvironment.flavor != AppEnvironment.prd &&
                    code.isNotNullOrEmpty
                ? ': $code'
                : ''),
      );
}
