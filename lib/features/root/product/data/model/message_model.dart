import 'package:nike_flutter/features/root/product/domain/entities/message_entity.dart';

class MessageModel extends MessageEntity {
  MessageModel({String? message}) : super(message: message);

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(message: json['message']);
  }
}
