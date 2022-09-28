import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../modules/auth/domain/interfaces/auth_repository_interface.dart';
import '../../../../modules/auth/infrastructure/models/user_model.dart';
import '../../../domain/errors/auth_error.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final IAuthRepository _repository;

  AuthCubit(
    this._repository,
  ) : super(() {
          final user = _repository.getUser();
          if (user != null) {
            return _Authenticated(user);
          } else {
            return const _Unauthenticated();
          }
        }());

  Future<void> login({required String email, required String password}) async {
    emit(const _Loading());
    final result = await _repository.login(email: email, password: password);
    emit(result.fold((l) => _Error(l), (r) {
      _repository.setUser(r);
      return _Authenticated(r);
    }));
  }

  void logout() async {
    await state.whenOrNull(authenticated: (_) async {
      emit(const _Loading());
      await _repository.logout();
      emit(const _Unauthenticated());
    });
  }
}
