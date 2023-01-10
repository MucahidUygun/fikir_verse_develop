// To parse this JSON data, do
//
//     final checkPaymentRequestsControl = checkPaymentRequestsControlFromJson(jsonString);

import 'dart:convert';

PaymentRequestsControl paymentRequestsControlFromJson(String str) =>
    PaymentRequestsControl.fromJson(json.decode(str));

class PaymentRequestsControl {
  PaymentRequestsControl({
    required this.status,
    required this.message,
  });

  final bool status;
  final Message? message;

  factory PaymentRequestsControl.fromJson(Map<String, dynamic> json) =>
      PaymentRequestsControl(
        status: json["status"],
        message:
            json['message'] != null ? Message.fromJson(json["message"]) : null,
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
