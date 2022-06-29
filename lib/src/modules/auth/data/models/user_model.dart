import 'package:hive_flutter/adapters.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  final String name;

  UserModel(this.name);
}
