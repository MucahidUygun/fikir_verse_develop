import 'package:dio/dio.dart';
import 'package:fikir_verse/core/init/config.dart';
import 'package:fikir_verse/core/init/network_client.dart';
import 'package:fikir_verse/core/model/webview_model.dart';

class WebViewServices {
  static Future<WebViewModel> postSurveyControl(String userId,String surveyId)async{
    try {
      var formData = FormData.fromMap({
        'token' : token,
        'user_id' : userId,
        'survey_id' : surveyId,
      });
      var response = await NetworkClient.instance!.dio.post('${siteBaseUrl}api/survey/surveyControlForMobile',data: formData);
      return WebViewModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}