import 'package:dio/dio.dart';
import 'package:fikir_verse/core/init/network_client.dart';
import 'package:fikir_verse/core/init/config.dart';
import 'package:fikir_verse/core/model/register_user_control.dart';

class LoginUser {
  static Future<RegisterUserControl> loginUser(
      String userEmail, String userPassword) async {
    try {
      var formData = FormData.fromMap({
        'user_email': userEmail,
        'user_password': userPassword,
        'token': token
      });
      var response = await NetworkClient.instance!.dio.post(
        '${siteBaseUrl}api/auth/login',
        data: formData
      );
      return RegisterUserControl.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
