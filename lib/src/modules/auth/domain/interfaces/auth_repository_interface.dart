import 'package:dartz/dartz.dart';

import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/auth/models/login_request.dart';
import '../../infrastructure/models/user_model.dart';

abstract class IAuthRepository {
  UserModel? getUser();
  Future setUser(UserModel val);
  Future<Either<ApiError, UserModel>> login(LoginRequest request);
  Future<String?> getAccessToken();
  Future setAccessToken(String? val);
  Future logout();
}
