import 'package:dartz/dartz.dart';

import '../../../../common/extensions/int_duration.dart';
import '../../../../common/utils/validator.dart';
import '../../../../core/domain/errors/auth_error.dart';
import '../../../../core/infrastructure/datasources/local/storage.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/auth/auth_service.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/auth/models/login_request.dart';
import '../../domain/interfaces/auth_repository_interface.dart';
import '../models/user_model.dart';

class AuthRepository implements IAuthRepository {
  final AuthService _service;

  AuthRepository(this._service);

  @override
  UserModel? getUser() => Storage.user;

  @override
  Future setUser(UserModel? val) async => Storage.setUser(val);

  @override
  Future<String?> getAccessToken() => Storage.accessToken;

  @override
  Future setAccessToken(String? val) => Storage.setAccessToken(val);

  @override
  Future<Either<AuthError, UserModel>> login({
    required String email,
    required String password,
  }) async {
    if (!Validator.isValidEmail(email)) {
      return left(const AuthError.invalidEmail());
    } else if (!Validator.isValidPassword(password)) {
      return left(const AuthError.invalidPassword());
    } else {
      final result =
          await _service.login(LoginRequest(email: email, password: password));
      return result.fold(
        (failure) {
          final errorMessage = failure.message;
          return left(AuthError.other(errorMessage));
        },
        (data) {
          return right(data.user);
        },
      );
    }
  }

  @override
  Future logout() async {
    await Future.delayed(1.seconds);
    await setUser(null);
  }
}
