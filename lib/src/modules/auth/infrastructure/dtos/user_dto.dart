import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

@freezed
class UserDTO with _$UserDTO implements User {
  const UserDTO._();

  const factory UserDTO({
    @Default('0') String id,
    @Default('') String name,
    @Default('') String email,
    @Default('') String avatar,
  }) = _UserDTO;

  factory UserDTO.fromJson(dynamic json) => _$UserDTOFromJson(json);
}
