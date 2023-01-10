import 'package:dio/dio.dart';
import 'package:fikir_verse/core/init/config.dart';
import 'package:fikir_verse/core/init/network_client.dart';
import 'package:fikir_verse/core/model/change_password_model.dart';

class ForgotPasswordServices {
  static Future<ChangePasswordModel> forgotPasswordFunction(
      String email) async {
    try {
      var formData = FormData.fromMap({'user_email': email, 'token': token});
      var response = await NetworkClient.instance!.dio
          .post('$siteBaseUrl/api/auth/forgotPassword', data: formData);
      return ChangePasswordModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
