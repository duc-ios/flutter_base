import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@unfreezed
@HiveType(typeId: 0)
class UserModel extends HiveObject with _$UserModel implements User {
  UserModel._();

  factory UserModel({
    @HiveField(0) @Default('') String name,
    @HiveField(1) @Default('') String email,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
