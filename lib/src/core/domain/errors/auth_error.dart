import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_error.freezed.dart';

@freezed
class AuthError with _$AuthError {
  const factory AuthError.invalidEmail() = _InvalidEmail;
  const factory AuthError.invalidPassword() = _InvalidPassword;
  const factory AuthError.other(String message) = _Other;
}
