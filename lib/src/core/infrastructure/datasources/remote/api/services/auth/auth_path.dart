import '../../base/api_path.dart';

class AuthPath implements APIPath {
  factory AuthPath.login(String password) => AuthPath(
      APIMethod.get, password == 'aA123456@' ? '/login' : '/login_failed');
  factory AuthPath.getUsers() => const AuthPath(APIMethod.get, '/user');
  factory AuthPath.getUserInfo(String id) =>
      AuthPath(APIMethod.post, '/user/$id');

  @override
  final String method;
  @override
  final String path;

  const AuthPath(this.method, this.path);
}
