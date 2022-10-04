import 'models/login_request.dart';

class AuthPath {
  static String login(LoginRequest request) =>
      request.password == 'aA12345@' ? '/login' : '/login_failed';
  static String get user => '/user';
  static String userWith(String id) => '/user/$id';
}
