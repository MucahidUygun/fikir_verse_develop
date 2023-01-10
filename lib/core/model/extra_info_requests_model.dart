// To parse this JSON data, do
//
//     final extraInfoRequestsModel = extraInfoRequestsModelFromJson(jsonString);

import 'dart:convert';

ExtraInfoRequestsModel extraInfoRequestsModelFromJson(String str) => ExtraInfoRequestsModel.fromJson(json.decode(str));


class ExtraInfoRequestsModel {
    ExtraInfoRequestsModel({
        required this.status,
        required this.isGiveGift,
        required this.message,
    });

    final bool status;
    final dynamic isGiveGift;
    final Message message;

    factory ExtraInfoRequestsModel.fromJson(Map<String, dynamic> json) => ExtraInfoRequestsModel(
        status: json["status"],
        isGiveGift: json["is_give_gift"],
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
