import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel implements User {
  const UserModel._();

  const factory UserModel({
    @JsonKey(name: 'first_name') @Default('') String firstName,
    @JsonKey(name: 'last_name') @Default('') String lastName,
    @JsonKey(name: 'email') @Default('') String email,
    @JsonKey(name: 'avatar') @Default('') String avatar,
  }) = _UserModel;

  factory UserModel.fromJson(dynamic json) => _$UserModelFromJson(json);

  @override
  String get name => '$firstName $lastName';
}
