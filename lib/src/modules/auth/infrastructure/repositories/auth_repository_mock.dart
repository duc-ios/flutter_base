import 'package:dartx/dartx.dart';
import 'package:dio/dio.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:injectable/injectable.dart';
import 'package:result_dart/result_dart.dart';

import '../../../../common/extensions/int_duration.dart';
import '../../../../common/utils/app_environment.dart';
import '../../../../core/infrastructure/datasources/local/storage.dart';
import '../../../../core/infrastructure/datasources/remote/api/base/api_error.dart';
import '../../../../core/infrastructure/datasources/remote/api/services/auth/models/login_request.dart';
import '../../domain/entities/user.dart';
import '../../domain/interfaces/auth_repository.dart';
import '../dtos/user_dto.dart';

@alpha
@LazySingleton(as: AuthRepository)
class AuthRepositoryMock implements AuthRepository {
  AuthRepositoryMock();

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
    final user = AuthDataSourceMock.users
        .firstOrNullWhere((user) => user.email == request.email);
    if (user == null) {
      return ApiError.server(message: 'Invalid email/password').toFailure();
    }
    return user.toSuccess();
  }

  @override
  Future logout({CancelToken? token}) async {
    await Future.delayed(1.seconds);
    await setUser(null);
  }

  @override
  Future<Result<List<UserDTO>, ApiError>> users({CancelToken? token}) async {
    return AuthDataSourceMock.users.toSuccess();
  }

  @override
  Future<Result<UserDTO, ApiError>> user(String id,
      {CancelToken? token}) async {
    final user =
        AuthDataSourceMock.users.firstOrNullWhere((user) => user.id == id);
    if (user == null) {
      return ApiError.server(message: '404 Not Found').toFailure();
    }
    return user.toSuccess();
  }
}

class AuthDataSourceMock {
  static final users = List.generate(9, (id) {
    final faker = Faker.instance;
    return UserDTO(
      id: id.toString(),
      name: faker.name.fullName(),
      email: id == 0 ? 'example@domain.com' : faker.internet.email(),
      avatar: faker.image.image(),
    );
  });
}
