part of 'auth_cubit.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated() = _Authenticated;
  const factory AuthState.unauthenticated() = _Unauthenticated;
}
