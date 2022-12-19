abstract class User {
  String get firstName;
  String get lastName;
  String get name;
  String get email;
  String get avatar;

  Map<String, dynamic> toJson();
}
