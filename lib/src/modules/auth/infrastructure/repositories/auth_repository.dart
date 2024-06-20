import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../common/extensions/int_duration.dart';
import '../../../../core/infrastructure/datasources/local/storage.dart';
import '../../../../core/infrastructure/datasources/remote/api/api_client.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/auth/auth_client.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/auth/models/login_request.dart';
import '../../domain/entities/user.dart';
import '../../domain/interfaces/auth_repository_interface.dart';
import '../models/user_model.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final AuthClient _client;

  AuthRepository(this._client);

  @override
  UserModel? getUser() => Storage.user;

  @override
  Future setUser(User? val) async {
    if (val is UserModel?) {
      return Storage.setUser(val);
    }
  }

  @override
  Future<String?> getAccessToken() => Storage.accessToken;

  @override
  Future setAccessToken(String? val) => Storage.setAccessToken(val);

  @override
  Future<Result<UserModel, ApiError>> login(
    LoginRequest request, {
    CancelToken? token,
  }) async {
    var result = _client.loginFailed(token);
    if (request.password == 'aA12345@') {
      result = _client.login(request, token);
    }
    return result.tryGet((response) => response.data.user);
  }

  @override
  Future logout({CancelToken? token}) async {
    await Future.delayed(1.seconds);
    await setUser(null);
  }

  @override
  Future<Result<List<UserModel>, ApiError>> users({CancelToken? token}) async {
    return await _client.users(token).tryGet((response) => response.data);
  }

  @override
  Future<Result<UserModel, ApiError>> user(String id,
      {CancelToken? token}) async {
    return await _client.user(id, token).tryGet((response) => response.data);
  }
}
