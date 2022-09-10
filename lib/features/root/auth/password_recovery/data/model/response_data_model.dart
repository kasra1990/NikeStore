import 'package:nike_flutter/features/root/auth/register/domain/entities/response_entity.dart';

class ResponseDataModel extends ResponseEntity {
  ResponseDataModel(
      {required String? message, required String? id, required String? email})
      : super(id: id, email: email, message: message);

  factory ResponseDataModel.fromJson(Map<String, dynamic> json) {
    return ResponseDataModel(
        message: json['message'], id: json["id"], email: json["email"]);
  }
}
