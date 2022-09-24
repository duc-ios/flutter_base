import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../../modules/auth/infrastructure/models/user_model.dart';

part 'login_response.freezed.dart';
part 'login_response.g.dart';

@freezed
class LoginResponse with _$LoginResponse {
  const factory LoginResponse({
    required UserModel user,
    required String accessToken,
  }) = _LoginResponse;

  factory LoginResponse.fromJson(dynamic json) => _$LoginResponseFromJson(json);
}
