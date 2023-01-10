// To parse this JSON data, do
//
//     final bankInfoDeleteModel = bankInfoDeleteModelFromJson(jsonString);
import 'dart:convert';

BankInfoDeleteModel bankInfoDeleteModelFromJson(String str) =>
    BankInfoDeleteModel.fromJson(json.decode(str));

class BankInfoDeleteModel {
  BankInfoDeleteModel({
    required this.status,
    required this.message,
  });

  final bool status;
  final Message message;

  factory BankInfoDeleteModel.fromJson(Map<String, dynamic> json) =>
      BankInfoDeleteModel(
        status: json["status"],
        message: Message.fromJson(json["message"]),
      );
}

class Message {
  Message({
    required this.title,
    required this.type,
    required this.message,
  });

  final String title;
  final String type;
  final String message;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        title: json["title"],
        type: json["type"],
        message: json["message"],
      );
}
