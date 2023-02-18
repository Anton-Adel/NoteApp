import 'package:note_app/Domian/Entity/User.dart';

class UserModel extends User {
  UserModel(
      {required super.id,
      required super.username,
      required super.email,
      required super.password});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'].toString(),
      username: json['username'].toString(),
      email: json['email'].toString(),
      password: json['password'].toString());
}
