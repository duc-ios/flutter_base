import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel implements User {
  const UserModel._();

  const factory UserModel({
    @Default('') String name,
    @Default('') String email,
    @Default('') String avatar,
  }) = _UserModel;

  factory UserModel.fromJson(dynamic json) => _$UserModelFromJson(json);
}
