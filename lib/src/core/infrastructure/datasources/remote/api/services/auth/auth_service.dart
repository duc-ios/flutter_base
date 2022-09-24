import 'package:dartz/dartz.dart';

import '../../../../../../../modules/auth/infrastructure/models/user_model.dart';
import '../../api_client.dart';
import '../../base/api_error.dart';
import 'auth_path.dart';
import 'models/login_request.dart';
import 'models/login_response.dart';

class AuthService {
  final ApiClient _client;

  AuthService(this._client);

  Future<Either<ApiError, LoginResponse>> login(LoginRequest request) async {
    final result = await _client.request(
      AuthPath.login(request.password),
      LoginResponse.fromJson,
      data: request.toJson(),
    );
    return result.single;
  }

  Future<Either<ApiError, List<UserModel>>> fetchUsers() async {
    final result = await _client.request(
      AuthPath.getUsers(),
      UserModel.fromJson,
    );
    return result.list;
  }
}
