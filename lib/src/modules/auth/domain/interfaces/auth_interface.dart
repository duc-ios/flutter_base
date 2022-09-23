import 'package:dartz/dartz.dart';

import '../../../../core/domain/errors/auth_error.dart';
import '../../infrastructure/models/user_model.dart';

abstract class AuthInterface {
  UserModel? getUser();
  Future setUser(UserModel val);
  Future<Either<AuthError, UserModel>> login({
    required String email,
    required String password,
  });
  Future logout();
}
