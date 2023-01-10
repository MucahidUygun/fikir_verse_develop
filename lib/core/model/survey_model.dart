// To parse this JSON data, do
//
//     final surveysssModel = surveysssModelFromJson(jsonString);

import 'dart:convert';

SurveyModel surveysssModelFromJson(String str) =>
    SurveyModel.fromJson(json.decode(str));

class SurveyModel {
  SurveyModel({
    this.attendedSurveys,
    this.willJoinSurveys,
    this.missedSurveys,
  });

  final List<AttendedSurvey>? attendedSurveys;
  final List<WillJoinSurvey>? willJoinSurveys;
  final List<MissedSurvey>? missedSurveys;
  factory SurveyModel.fromJson(Map<String, dynamic> json) => SurveyModel(
        attendedSurveys: List<AttendedSurvey>.from(
            json["attended_surveys"].map((x) => AttendedSurvey.fromJson(x))),
        willJoinSurveys: List<WillJoinSurvey>.from(
            json["will_join_surveys"].map((x) => WillJoinSurvey.fromJson(x))),
        missedSurveys: List<MissedSurvey>.from(
            json["missed_surveys"].map((x) => MissedSurvey.fromJson(x))),
      );
}

class AttendedSurvey {
  AttendedSurvey({
    this.survey,
    this.project,
    this.surveyAttendedInfo,
  });

  final Survey? survey;
  final Project? project;
  final SurveyAttendedInfoClass? surveyAttendedInfo;

  factory AttendedSurvey.fromJson(Map<String, dynamic> json) => AttendedSurvey(
        survey: Survey.fromJson(json["survey"]),
        project: Project.fromJson(json["project"]),
        surveyAttendedInfo:
            SurveyAttendedInfoClass.fromJson(json["survey_attended_info"]),
      );
}

class Project {
  Project({
    this.id,
    this.title,
    this.desc,
    this.isactive,
    this.isdelete,
    this.createtime,
    this.timestamp,
  });

  final String? id;
  final String? title;
  final String? desc;
  final String? isactive;
  final String? isdelete;
  final DateTime? createtime;
  final DateTime? timestamp;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        id: json["id"],
        title: json["title"],
        desc: json["desc"],
        isactive: json["isactive"],
        isdelete: json["isdelete"],
        createtime: DateTime.parse(json["createtime"]),
        timestamp: DateTime.parse(json["timestamp"]),
      );
}

class Survey {
  Survey({
    this.idEncrypted,
    this.id,
    this.projectId,
    this.title,
    this.url,
    this.positivePoint,
    this.negativePoint,
    this.positiveCallback,
    this.negativeCallback,
    this.startdateFormatted,
    this.enddateFormatted,
    this.isactive,
    this.isdelete,
    this.createtime,
    this.timestamp,
    required this.isProfileCompleteCard,
  });

  final String? id;
  final String? idEncrypted;
  final String? projectId;
  final String? title;
  final String? url;
  final String? positivePoint;
  final String? negativePoint;
  final String? positiveCallback;
  final String? negativeCallback;
  final String? startdateFormatted;
  final String? enddateFormatted;
  final String? isactive;
  final String? isdelete;
  final DateTime? createtime;
  final DateTime? timestamp;
  final bool isProfileCompleteCard;

  factory Survey.fromJson(Map<String?, dynamic> json) => Survey(
        idEncrypted: json['id_encrypted'],
        id: json["id"],
        projectId: json["project_id"],
        title: json["title"],
        url: json["url"],
        positivePoint: json["positive_point"],
        negativePoint: json["negative_point"],
        positiveCallback: json["positive_callback"],
        negativeCallback: json["negative_callback"],
        startdateFormatted: json["startdate_formatted"],
        enddateFormatted: json["enddate_formatted"],
        isactive: json["isactive"],
        isdelete: json["isdelete"],
        createtime: DateTime.parse(json["createtime"]),
        timestamp: DateTime.parse(json["timestamp"]),
        isProfileCompleteCard: json['is_profile_complete_card'],
      );
}

class SurveyAttendedInfoClass {
  SurveyAttendedInfoClass({
    this.pointType,
    this.pointPoint,
    this.pointCreatetimeFormatted,
  });

  final String? pointType;
  final String? pointPoint;
  final String? pointCreatetimeFormatted;

  factory SurveyAttendedInfoClass.fromJson(Map<String, dynamic> json) =>
      SurveyAttendedInfoClass(
        pointType: json["point_type"],
        pointPoint: json["point_point"],
        pointCreatetimeFormatted: json["point_createtime_formatted"],
      );
}

class MissedSurvey {
  MissedSurvey({
    this.survey,
    this.project,
    this.surveyAttendedInfo,
  });

  final Survey? survey;
  final Project? project;
  final SurveyAttendedInfoClass? surveyAttendedInfo;

  factory MissedSurvey.fromJson(Map<String, dynamic> json) => MissedSurvey(
        survey: Survey.fromJson(json["survey"]),
        project: Project.fromJson(json["project"]),
        surveyAttendedInfo:
            SurveyAttendedInfoClass.fromJson(json["survey_attended_info"]),
      );
}

class WillJoinSurvey {
  WillJoinSurvey({
    this.survey,
    this.project,
    this.surveyAttendedInfo,
  });

  final Survey? survey;
  final Project? project;
  final SurveyAttendedInfoClass? surveyAttendedInfo;

  factory WillJoinSurvey.fromJson(Map<String, dynamic> json) => WillJoinSurvey(
        survey: Survey.fromJson(json["survey"]),
        project: Project.fromJson(json["project"]),
        surveyAttendedInfo:
            SurveyAttendedInfoClass.fromJson(json["survey_attended_info"]),
      );
}
