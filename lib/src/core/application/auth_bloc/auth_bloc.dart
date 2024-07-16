import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:riverbloc/riverbloc.dart';

import '../../../common/mixin/safe_bloc_base.dart';
import '../../../common/utils/getit_utils.dart';
import '../../../common/utils/validator.dart';
import '../../../modules/auth/domain/entities/user.dart';
import '../../../modules/auth/domain/interfaces/auth_repository.dart';
import '../../domain/errors/auth_error.dart';
import '../../infrastructure/datasources/remote/api/services/auth/models/login_request.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

final authProvider =
    AutoDisposeBlocProvider<AuthBloc, AuthState>((_) => getIt<AuthBloc>());

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> with SafeBlocBase {
  final AuthRepository _repository;

  AuthBloc(
    this._repository,
  ) : super(() {
          final user = _repository.getUser();
          if (user != null) {
            return _Authenticated(user);
          } else {
            return const _Unauthenticated();
          }
        }()) {
    on<AuthEvent>(
      (event, emit) => event.when(
        login: (request) => _login(request, emit),
        logout: () => _logout(emit),
      ),
    );
  }

  void _login(LoginRequest request, Emitter<AuthState> emit) async {
    if (!Validator.isValidEmail(request.email)) {
      emit(const _Error(AuthError.invalidEmail()));
    } else if (!Validator.isValidPassword(request.password)) {
      emit(const _Error(AuthError.invalidPassword()));
    } else {
      emit(const _Loading());
      final result = await _repository.login(request);
      emit(await result.fold(
        (success) async {
          await _repository.setUser(success);
          return _Authenticated(success);
        },
        (failure) => _Error(AuthError.api(failure)),
      ));
    }
  }

  void _logout(Emitter<AuthState> emit) async {
    await state.whenOrNull(authenticated: (_) async {
      emit(const _Loading());
      await _repository.logout();
      emit(const _Unauthenticated());
    });
  }
}
