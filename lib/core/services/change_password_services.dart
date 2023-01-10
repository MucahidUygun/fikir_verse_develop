import 'package:dio/dio.dart';
import 'package:fikir_verse/core/init/config.dart';
import 'package:fikir_verse/core/init/network_client.dart';
import 'package:fikir_verse/core/model/change_password_model.dart';

class ChangePasswordServices {
  static Future<ChangePasswordModel> checkPassword(
      String userId,
      String currentPassword,
      String newPassword,
      String newPasswordAgain) async {
    try {
      var formData = FormData.fromMap(
        {
          'user_id': userId,
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_again': newPasswordAgain,
          'token': token,
        },
      );
      var response = await NetworkClient.instance!.dio
          .post('$siteBaseUrl/api/my-account/changePassword', data: formData);
      return ChangePasswordModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
