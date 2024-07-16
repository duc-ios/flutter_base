import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../common/extensions/int_duration.dart';
import '../../../../common/utils/app_environment.dart';
import '../../../../core/domain/errors/api_error.dart';
import '../../../../core/infrastructure/datasources/local/storage.dart';
import '../../../../core/infrastructure/datasources/remote/api/api_x.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/auth/auth_client.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/auth/models/login_request.dart';
import '../../domain/entities/user.dart';
import '../../domain/interfaces/auth_repository.dart';
import '../dtos/user_dto.dart';

@LazySingleton(as: AuthRepository, env: AppEnvironment.environments, order: -1)
class AuthRepositoryImpl implements AuthRepository {
  final AuthClient _client;

  AuthRepositoryImpl(this._client);

  @override
  UserDTO? getUser() => Storage.user;

  @override
  Future setUser(User? val) async {
    if (val is UserDTO?) {
      return Storage.setUser(val);
    }
  }

  @override
  Future<String?> getAccessToken() => Storage.accessToken;

  @override
  Future setAccessToken(String? val) => Storage.setAccessToken(val);

  @override
  Future<Result<UserDTO, ApiError>> login(
    LoginRequest request, {
    CancelToken? token,
  }) async {
    if (request.password == 'aA12345@') {
      return _client
          .login(request, token)
          .tryGet((response) => response.data.user);
    } else {
      return _client
          .loginFailed(token)
          .tryGet((response) => response.data.user);
    }
  }

  @override
  Future logout({CancelToken? token}) async {
    await Future.delayed(1.seconds);
    await setUser(null);
  }

  @override
  Future<Result<List<UserDTO>, ApiError>> users({CancelToken? token}) async {
    return await _client.users(token).tryGet((response) => response.data);
  }

  @override
  Future<Result<UserDTO, ApiError>> user(String id,
      {CancelToken? token}) async {
    return await _client.user(id, token).tryGet((response) => response.data);
  }
}
