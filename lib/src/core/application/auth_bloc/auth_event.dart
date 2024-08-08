part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login(LoginRequest request) = _Login;
  const factory AuthEvent.logout() = _Logout;
}
