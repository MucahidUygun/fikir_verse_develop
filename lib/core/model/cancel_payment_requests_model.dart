// To parse this JSON data, do
//
//     final cancelPaymentRequestsModel = cancelPaymentRequestsModelFromJson(jsonString);

import 'dart:convert';

CancelPaymentRequestsModel cancelPaymentRequestsModelFromJson(String str) =>
    CancelPaymentRequestsModel.fromJson(json.decode(str));


class CancelPaymentRequestsModel {
  CancelPaymentRequestsModel({
    required this.status,
    required this.error,
  });

  final bool status;
  final Error? error;

  factory CancelPaymentRequestsModel.fromJson(Map<String, dynamic> json) =>
      CancelPaymentRequestsModel(
        status: json["status"],
        error: json["error"] != null? Error.fromJson(json["error"]):null,
      );
}

class Error {
  Error({
     this.title,
     this.type,
     this.message,
  });

  final String? title;
  final String? type;
  final String? message;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        title: json["title"],
        type: json["type"],
        message: json["message"],
      );
}
