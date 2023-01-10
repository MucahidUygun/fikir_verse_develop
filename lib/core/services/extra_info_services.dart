import 'package:dio/dio.dart';
import 'package:fikir_verse/core/init/config.dart';
import 'package:fikir_verse/core/init/network_client.dart';
import 'package:fikir_verse/core/model/extra_info_get_model.dart';
import 'package:fikir_verse/core/model/extra_info_requests_model.dart';

class ExtraInfoServices {
  static Future<ExtraInfoRequestsModel> postHouseProfile(
      String userId, int? question_1, int? question_2, int? question_3) async {
    try {
      var formData = FormData.fromMap({
        'user_id': userId,
        'question_1': question_1,
        'question_2': question_2,
        'question_3': question_3,
        'token': token
      });
      var response = await NetworkClient.instance!.dio
          .post('$siteBaseUrl/api/my-account/updateExtraInfo1', data: formData);
      return ExtraInfoRequestsModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<ExtraInfoRequestsModel> postUsageHabits(
      String userId,
      int? question1,
      int? question2,
      int? question3,
      int? question4,
      int? question5,
      int? question6,
      int? question7,
      int? question8,
      int? question9,
      List<int>? question10,
      List<int>? question11,
      List<int>? question12,
      List<int>? question13,
      List<int>? question14,
      List<int>? question15) async {
    try {
      //List<dynamic>.from(question10!.map((e) => e))

      var formData = FormData.fromMap({
        'user_id': userId,
        'question_1': question1,
        'question_2': question2,
        'question_3': question3,
        'question_4': question4,
        'question_5': question5,
        'question_6': question6,
        'question_7': question7,
        'question_8': question8,
        'question_9': question9,
        'question_10': toJsonList(question10!),
        'question_11': toJsonList( question11!),
        'question_12': toJsonList( question12!),
        'question_13': toJsonList( question13!),
        'question_14': toJsonList( question14!),
        'question_15': toJsonList( question15!),
        'token': token,
        'is_mobile': true
      });
      var response = await NetworkClient.instance!.dio
          .post('$siteBaseUrl/api/my-account/updateExtraInfo2', data: formData);
      return ExtraInfoRequestsModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<ExtraInfoGetModel> getAllQuestions(String userId) async {
    try {
      var response = await NetworkClient.instance!.dio
          .get('$siteBaseUrl/api/my-account/$userId/$token/getExtraInfos');
      return ExtraInfoGetModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

String toJsonList( List<int> list) {
  String dataName='';
  for (var i = 0; i < list.length; i++) {
    dataName = dataName + ',${list[i]}';
  }
  return dataName.trimLeft();
}
