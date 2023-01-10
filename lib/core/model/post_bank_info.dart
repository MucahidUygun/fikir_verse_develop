// To parse this JSON data, do
//
//     final PostBankInfoModel = PostBankInfoModelFromJson(jsonString);

import 'dart:convert';

PostBankInfoModel postBankInfoModelFromJson(String str) => PostBankInfoModel.fromJson(json.decode(str));


class PostBankInfoModel {
    PostBankInfoModel({
        required this.status,
        required this.message,
    });

    final bool status;
    final Message message;

    factory PostBankInfoModel.fromJson(Map<String, dynamic> json) => PostBankInfoModel(
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
