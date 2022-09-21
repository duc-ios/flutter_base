import '../../infrastructure/models/user_model.dart';

abstract class AuthInterface {
  UserModel? getUser();
  Future setUser(UserModel val);
  Future<UserModel?> login({
    required String email,
    required String password,
  });
  Future logout();
}
