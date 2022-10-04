import 'package:dartz/dartz.dart';

import '../../../../common/extensions/int_duration.dart';
import '../../../../core/infrastructure/datasources/local/storage.dart';
import '../../../../core/infrastructure/datasources/remote/api/api_client.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_path.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_response.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/auth/auth_path.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/auth/models/login_request.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/auth/models/login_response.dart';
import '../../domain/interfaces/auth_repository_interface.dart';
import '../models/user_model.dart';

class AuthRepository implements IAuthRepository {
  final ApiClient _client;

  AuthRepository(this._client);

  @override
  UserModel? getUser() => Storage.user;

  @override
  Future setUser(UserModel? val) async => Storage.setUser(val);

  @override
  Future<String?> getAccessToken() => Storage.accessToken;

  @override
  Future setAccessToken(String? val) => Storage.setAccessToken(val);

  @override
  Future<Either<ApiError, UserModel>> login(LoginRequest request) async {
    final response = await _client.request(
      path: AuthPath.login(request),
      method: ApiMethod.get,
      fromJsonT: (json) => SingleApiResponse<LoginResponse>.fromJson(
          json, LoginResponse.fromJson),
    );
    return response.fold((l) => left(l), (r) => right(r.data.user));
  }

  Future<Either<ApiError, List<UserModel>>> getAllUsers() async {
    final response = await _client.request(
      path: AuthPath.user,
      method: ApiMethod.get,
      fromJsonT: (json) =>
          ListApiResponse<UserModel>.fromJson(json, UserModel.fromJson),
    );
    return response.fold((l) => left(l), (r) => right(r.data));
  }

  @override
  Future logout() async {
    await Future.delayed(1.seconds);
    await setUser(null);
  }
}
