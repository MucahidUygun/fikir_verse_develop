// To parse this JSON data, do
//
//     final webViewModel = webViewModelFromJson(jsonString);

import 'dart:convert';

WebViewModel webViewModelFromJson(String str) => WebViewModel.fromJson(json.decode(str));


class WebViewModel {
    WebViewModel({
        required this.status,
        required this.message,
    });

    final bool status;
    final Message message;

    factory WebViewModel.fromJson(Map<String, dynamic> json) => WebViewModel(
        status: json["status"],
        message: Message.fromJson(json["message"]),
    );

}

class Message {
    Message({
        required this.type,
        required this.title,
        required this.message,
        this.surveyUrl,
    });

    final String type;
    final String title;
    final String message;
    final String? surveyUrl;

    factory Message.fromJson(Map<String, dynamic> json) => Message(
        type: json["type"],
        title: json["title"],
        message: json["message"],
        surveyUrl: json["survey_url"],
    );

}
