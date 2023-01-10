// To parse this JSON data, do
//
//     final extraInfoGetModel = extraInfoGetModelFromJson(jsonString);

import 'dart:convert';

ExtraInfoGetModel extraInfoGetModelFromJson(String str) =>
    ExtraInfoGetModel.fromJson(json.decode(str));

String extraInfoGetModelToJson(ExtraInfoGetModel data) =>
    json.encode(data.toJson());

class ExtraInfoGetModel {
  ExtraInfoGetModel({
    required this.extraInfo1,
    required this.extraInfo2,
  });

  final ExtraInfo1? extraInfo1;
  final ExtraInfo2? extraInfo2;

  factory ExtraInfoGetModel.fromJson(Map<String, dynamic> json) =>
      ExtraInfoGetModel(
        extraInfo1: ExtraInfo1.fromJson(json["extra_info_1"]),
        extraInfo2: ExtraInfo2.fromJson(json["extra_info_2"]),
      );

  Map<String, dynamic> toJson() => {
        "extra_info_1": extraInfo1!.toJson(),
        "extra_info_2": extraInfo2!.toJson(),
      };
}

class ExtraInfo1 {
  ExtraInfo1({
    required this.status,
    this.id,
    this.userId,
    this.question1,
    this.question2,
    this.question3,
  });

  final bool status;
  final String? id;
  final String? userId;
  final int? question1;
  final int? question2;
  final int? question3;

  factory ExtraInfo1.fromJson(Map<String, dynamic> json) => ExtraInfo1(
        status: json["status"],
        id: json["id"],
        userId: json["user_id"],
        question1: json["question_1"],
        question2: json["question_2"],
        question3: json["question_3"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "user_id": userId,
        "question_1": question1,
        "question_2": question2,
        "question_3": question3,
      };
}

class ExtraInfo2 {
  ExtraInfo2({
    required this.status,
    this.id,
    this.userId,
    this.question1,
    this.question2,
    this.question3,
    this.question4,
    this.question5,
    this.question6,
    this.question7,
    this.question8,
    this.question9,
    this.question10,
    this.question11,
    this.question12,
    this.question13,
    this.question14,
    this.question15,
  });

  final bool status;
  final String? id;
  final String? userId;
  final int? question1;
  final int? question2;
  final int? question3;
  final int? question4;
  final int? question5;
  final int? question6;
  final int? question7;
  final int? question8;
  final int? question9;
  final Question1? question10;
  final Question1? question11;
  final Question1? question12;
  final Question1? question13;
  final Question1? question14;
  final Question1? question15;

  factory ExtraInfo2.fromJson(Map<String, dynamic> json) => ExtraInfo2(
        status: json["status"],
        id: json["id"],
        userId: json["user_id"],
        question1: json["question_1"],
        question2: json["question_2"],
        question3: json["question_3"],
        question4: json["question_4"],
        question5: json["question_5"],
        question6: json["question_6"],
        question7: json["question_7"],
        question8: json["question_8"],
        question9: json["question_9"],
        question10: Question1.fromJson(json["question_10"]),
        question11: Question1.fromJson(json["question_11"]),
        question12: Question1.fromJson(json["question_12"]),
        question13: Question1.fromJson(json["question_13"]),
        question14: Question1.fromJson(json["question_14"]),
        question15: Question1.fromJson(json["question_15"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "id": id,
        "user_id": userId,
        "question_1": question1,
        "question_2": question2,
        "question_3": question3,
        "question_4": question4,
        "question_5": question5,
        "question_6": question6,
        "question_7": question7,
        "question_8": question8,
        "question_9": question9,
        "question_10": question10!.toJson(),
        "question_11": question11!.toJson(),
        "question_12": question12!.toJson(),
        "question_13": question13!.toJson(),
        "question_14": question14!.toJson(),
        "question_15": question15!.toJson(),
      };
}

class Question1 {
  Question1({
    required this.answers,
  });

  final List<int> answers;

  factory Question1.fromJson(Map<String, dynamic> json) => Question1(
        answers: List<int>.from(json["answers"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "answers": List<dynamic>.from(answers.map((x) => x)),
      };
}
