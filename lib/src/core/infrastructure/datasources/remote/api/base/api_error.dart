import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../generated/l10n.dart';

part 'api_error.freezed.dart';
part 'api_error.g.dart';

@freezed
class ApiError with _$ApiError {
  factory ApiError({required int? code, required String message}) = _ApiError;
  factory ApiError.fromJson(Map<String, dynamic> json) =>
      ApiError(code: json['code'], message: json['message']);

  factory ApiError.network({required int? code, required String message}) =
      _Network;
  factory ApiError.server({required int? code, required String message}) =
      _Server;
  factory ApiError.internal({required String message}) = _Internal;
  factory ApiError.unexpected() = _Unexpected;
  factory ApiError.unauthorized() = _Unauthorized;

  ApiError._();

  String get message => when(
        (code, message) => message,
        network: (code, message) => message,
        server: (code, message) => message,
        internal: (message) => message,
        unexpected: () => S.current.error_unexpected,
        unauthorized: () => S.current.error_unauthorized,
      );
}
