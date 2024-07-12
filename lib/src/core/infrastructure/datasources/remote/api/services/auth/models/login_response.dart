import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../../modules/auth/infrastructure/dtos/user_dto.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    @Default(UserDTO()) UserDTO user,
    @Default('') String accessToken,
  }) = _LoginResponse;

  const LoginResponse._();
  factory LoginResponse.fromJson(json) => _$LoginResponseFromJson(json);
}
