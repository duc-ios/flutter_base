import 'package:dio/dio.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../core/domain/errors/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/auth/models/login_request.dart';
import '../entities/user.dart';

abstract class AuthRepository {
  User? getUser();
  Future setUser(User? val);
  Future<String?> getAccessToken();
  Future setAccessToken(String? val);
  Future<Result<User, ApiError>> login(
    LoginRequest request, {
    CancelToken? token,
  });
  Future logout({CancelToken? token});
  Future<Result<List<User>, ApiError>> users({CancelToken? token});
  Future<Result<User, ApiError>> user(String id, {CancelToken? token});
}
