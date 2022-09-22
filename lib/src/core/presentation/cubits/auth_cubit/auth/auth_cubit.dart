import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../modules/auth/application/auth_service.dart';
import '../../../../../modules/auth/infrastructure/models/user_model.dart';
import '../../../../domain/errors/auth_error.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _service;

  AuthCubit(
    this._service,
  ) : super(() {
          final user = _service.getUser();
          if (user != null) {
            return AuthState.authenticated(user);
          } else {
            return const AuthState.unauthenticated();
          }
        }());

  Future<void> login({required String email, required String password}) async {
    emit(const AuthState.loading());
    final result = await _service.login(email: email, password: password);
    emit(result.fold((l) => AuthState.error(l), (r) {
      _service.setUser(r);
      return AuthState.authenticated(r);
    }));
  }

  void logout() async {
    emit(const AuthState.loading());
    await _service.logout();
    emit(const AuthState.unauthenticated());
  }
}
