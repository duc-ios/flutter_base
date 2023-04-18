import 'package:dartz/dartz.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/auth/models/login_request.dart';
import '../entities/user.dart';

abstract class IAuthRepository {
  User? getUser();
  Future setUser(User? val);
  Future<Either<ApiError, User>> login(LoginRequest request);
  Future<String?> getAccessToken();
  Future setAccessToken(String? val);
  Future logout();
}
