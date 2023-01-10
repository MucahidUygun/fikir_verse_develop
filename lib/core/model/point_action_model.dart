// To parse this JSON data, do
//
//     final pointActionModel = pointActionModelFromJson(jsonString);

import 'dart:convert';

PointActionModel pointActionModelFromJson(String str) => PointActionModel.fromJson(json.decode(str));


class PointActionModel {
    PointActionModel({
        required this.pointActions,
    });

    final List<PointAction> pointActions;

    factory PointActionModel.fromJson(Map<String, dynamic> json) => PointActionModel(
        pointActions: List<PointAction>.from(json["point_actions"].map((x) => PointAction.fromJson(x))),
    );
}

class PointAction {
    PointAction({
        required this.id,
        required this.userId,
        required this.surveyId,
        required this.paymentActionId,
        required this.actionType,
        required this.type,
        required this.plusMinus,
        required this.point,
        required this.isactive,
        required this.isdelete,
        required this.createtime,
        required this.timestamp,
    });

    final String id;
    final String userId;
    final String surveyId;
    final String paymentActionId;
    final String actionType;
    final String type;
    final String plusMinus;
    final String point;
    final String isactive;
    final String isdelete;
    final DateTime createtime;
    final DateTime timestamp;

    factory PointAction.fromJson(Map<String, dynamic> json) => PointAction(
        id: json["id"],
        userId: json["user_id"],
        surveyId: json["survey_id"],
        paymentActionId: json["payment_action_id"],
        actionType: json["action_type"],
        type: json["type"],
        plusMinus: json["plus_minus"],
        point: json["point"],
        isactive: json["isactive"],
        isdelete: json["isdelete"],
        createtime: DateTime.parse(json["createtime"]),
        timestamp: DateTime.parse(json["timestamp"]),
    );
}
