import 'package:dartz/dartz.dart';

import '../../../core/domain/errors/auth_error.dart';
import '../infrastructure/models/user_model.dart';
import '../infrastructure/repositories/auth_repository.dart';

class AuthService {
  final AuthRepository _repository;

  AuthService(this._repository);

  UserModel? getUser() => _repository.getUser();
  Future setUser(UserModel? val) => _repository.setUser(val);
  Future<Either<AuthError, UserModel>> login({
    required String email,
    required String password,
  }) =>
      _repository.login(email: email, password: password);
  Future logout() => _repository.logout();
}
