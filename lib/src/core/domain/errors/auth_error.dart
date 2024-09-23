import 'package:freezed_annotation/freezed_annotation.dart';

import 'api_error.dart';

part 'auth_error.freezed.dart';

@freezed
class AuthError with _$AuthError {
  const factory AuthError.invalidEmail() = _InvalidEmail;
  const factory AuthError.invalidPassword() = _InvalidPassword;
  const factory AuthError.api(ApiError error) = _API;
  const factory AuthError.other(String message) = _Other;
}
