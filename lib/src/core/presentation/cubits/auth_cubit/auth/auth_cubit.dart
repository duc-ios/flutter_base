import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../modules/auth/application/auth_service.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _service;

  AuthCubit(
    this._service,
  ) : super((_service.getUser() != null)
            ? const AuthState.authenticated()
            : const AuthState.unauthenticated());

  Future<void> login({required String email, required String password}) async {
    emit(const AuthState.loading());
    try {
      final user = await _service.login(email: email, password: password);
      _service.setUser(user);
      emit(const AuthState.authenticated());
    } catch (error) {
      emit(const AuthState.unauthenticated());
      rethrow;
    }
  }

  void logout() async {
    emit(const AuthState.loading());
    await _service.logout();
    emit(const AuthState.unauthenticated());
  }
}
