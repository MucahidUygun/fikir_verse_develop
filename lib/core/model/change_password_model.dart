// To parse this JSON data, do
//
//     final changePasswordModel = changePasswordModelFromJson(jsonString);

import 'dart:convert';

ChangePasswordModel changePasswordModelFromJson(String str) => ChangePasswordModel.fromJson(json.decode(str));

String changePasswordModelToJson(ChangePasswordModel data) => json.encode(data.toJson());

class ChangePasswordModel {
    ChangePasswordModel({
        this.status,
        this.message,
    });

    bool? status;
    Message? message;

    factory ChangePasswordModel.fromJson(Map<String, dynamic> json) => ChangePasswordModel(
        status: json["status"],
        message: Message.fromJson(json["message"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message!.toJson(),
    };
}

class Message {
    Message({
        this.title,
        this.type,
        this.message,
    });

    String? title;
    String? type;
    String? message;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        title: json["title"],
        type: json["type"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "type": type,
        "message": message,
    };
}
