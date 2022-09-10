import 'package:nike_flutter/features/root/auth/register/domain/entities/auth_data_entity.dart';

class AuthDataModel extends AuthDataEntity {
  AuthDataModel(
      {required String? userId,
      required String? email,
      required String? message})
      : super(userId: userId, email: email, message: message);

  factory AuthDataModel.fromJson(Map<String, dynamic> json) {
    return AuthDataModel(
        userId: json['userId'], email: json['email'], message: json['message']);
  }
}
