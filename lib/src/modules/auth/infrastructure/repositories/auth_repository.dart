import '../../../../common/extensions/int_duration.dart';
import '../../../../common/utils/hive_utils.dart';
import '../../../../common/utils/logger.dart';
import '../../../../common/utils/validator.dart';
import '../../../../core/domain/errors/auth_error.dart';
import '../../../../core/domain/errors/failure.dart';
import '../../domain/interfaces/auth_interface.dart';
import '../models/user_model.dart';

class AuthRepository implements AuthInterface {
  @override
  UserModel? getUser() {
    try {
      return box.get(BoxKeys.user);
    } catch (error) {
      logger.e(error);
      return null;
    }
  }

  @override
  Future setUser(UserModel? val) async => box.put(BoxKeys.user, val);

  @override
  Future<UserModel?> login({
    required String email,
    required String password,
  }) async {
    if (!Validator.isValidEmail(email)) {
      throw const AuthError.invalidEmail();
    } else if (!Validator.isValidPassword(password)) {
      throw const AuthError.invalidPassword();
    } else {
      await Future.delayed(1.seconds);
      if (email == 'e@ma.il' && password == 'aA123456@') {
        return UserModel(name: 'Test User', email: email);
      } else {
        throw Failure('Invalid email/password!');
      }
    }
  }

  @override
  Future logout() async {
    await Future.delayed(1.seconds);
    await setUser(null);
  }
}
