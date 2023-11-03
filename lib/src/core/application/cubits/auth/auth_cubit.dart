import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/utils/validator.dart';
import '../../../../modules/auth/domain/entities/user.dart';
import '../../../../modules/auth/domain/interfaces/auth_repository_interface.dart';
import '../../../domain/errors/auth_error.dart';
import '../../../infrastructure/datasources/remote/api/services/auth/models/login_request.dart';

part 'auth_cubit.freezed.dart';
part 'auth_state.dart';

@singleton
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

  Future<void> login(LoginRequest request) async {
    if (!Validator.isValidEmail(request.email)) {
      emit(const _Error(AuthError.invalidEmail()));
    } else if (!Validator.isValidPassword(request.password)) {
      emit(const _Error(AuthError.invalidPassword()));
    } else {
      emit(const _Loading());
      final result = await _repository.login(request);
      emit(result.fold(
        (success) {
          _repository.setUser(success);
          return _Authenticated(success);
        },
        (failure) => _Error(
          AuthError.other(failure.message),
        ),
      ));
    }
  }

  void logout() async {
    await state.whenOrNull(authenticated: (_) async {
      emit(const _Loading());
      await _repository.logout();
      emit(const _Unauthenticated());
    });
  }
}
