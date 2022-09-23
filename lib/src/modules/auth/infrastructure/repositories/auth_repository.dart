import 'package:dartz/dartz.dart';

import '../../../../common/extensions/int_duration.dart';
import '../../../../common/utils/logger.dart';
import '../../../../common/utils/storage.dart';
import '../../../../common/utils/validator.dart';
import '../../../../core/domain/errors/auth_error.dart';
import '../../domain/interfaces/auth_interface.dart';
import '../models/user_model.dart';

class AuthRepository implements AuthInterface {
  @override
  UserModel? getUser() {
    try {
      return Storage.user;
    } catch (error) {
      logger.e(error);
      return null;
    }
  }

  @override
  Future setUser(UserModel? val) async => Storage.setUser(val);

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
      await Future.delayed(1.seconds);
      if (email == 'e@ma.il' && password == 'aA123456@') {
        return right(UserModel(name: 'Test User', email: email));
      } else {
        return left(const AuthError.other('Invalid email or password!'));
      }
    }
  }

  @override
  Future logout() async {
    await Future.delayed(1.seconds);
    await setUser(null);
  }
}
