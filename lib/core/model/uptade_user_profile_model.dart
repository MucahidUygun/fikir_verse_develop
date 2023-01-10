// To parse this JSON data, do
//
//     final updateUserProfileModel = updateUserProfileModelFromJson(jsonString);

import 'dart:convert';

UpdateUserProfileModel updateUserProfileModelFromJson(String str) =>
    UpdateUserProfileModel.fromJson(json.decode(str));

class UpdateUserProfileModel {
  UpdateUserProfileModel({
    this.userId,
    required this.status,
    required this.userName,
    required this.userSurname,
    required this.userEmail,
    required this.userPassword,
    required this.userDateOfBirth,
    required this.userPhone,
    required this.userCity,
    required this.userGender,
    required this.userMaritalStatus,
    required this.userWorkingStatus,
    required this.userIsactive,
    required this.userIsdelete,
    required this.point,
  });

  final bool status;
  final String? userId;
  final String userName;
  final String userSurname;
  final String userEmail;
  final String userPassword;
  final DateTime userDateOfBirth;
  final String userPhone;
  final String userCity;
  final String userGender;
  final String userMaritalStatus;
  final String userWorkingStatus;
  final String userIsactive;
  final String userIsdelete;
  final int point;

  factory UpdateUserProfileModel.fromJson(Map<String, dynamic> json) =>
      UpdateUserProfileModel(
        status: json["status"],
        userId: json["user_id"],
        userName: json["user_name"],
        userSurname: json["user_surname"],
        userEmail: json["user_email"],
        userPassword: json["user_password"],
        userDateOfBirth: DateTime.parse(json["user_date_of_birth"]),
        userPhone: json["user_phone"],
        userCity: json["user_city"],
        userGender: json["user_gender"],
        userMaritalStatus: json["user_marital_status"],
        userWorkingStatus: json["user_working_status"],
        userIsactive: json["user_isactive"],
        userIsdelete: json["user_isdelete"],
        point: json["point"],
      );
}
