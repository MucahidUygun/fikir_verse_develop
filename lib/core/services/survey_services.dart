import 'package:fikir_verse/core/init/network_client.dart';
import 'package:fikir_verse/core/model/survey_model.dart';
import 'package:fikir_verse/core/init/config.dart';

class SurveyServices {
  static Future<SurveyModel> getSurvey(String userID) async {
    try {
      var response = await NetworkClient.instance!.dio
          .get('$siteBaseUrl/api/survey/$userID/$token/getSurveys');
      return SurveyModel.fromJson(response.data);
    } catch (e) {
     throw Exception(e.toString());
    }
  }
}
