import 'package:dio/dio.dart';
import 'package:fikir_verse/core/init/config.dart';
import 'package:fikir_verse/core/init/network_client.dart';

class PostToken {
  static Future<void> postToken(String fcmToken,String userId) async {
    try {
      var formData = FormData.fromMap({'device_token': fcmToken, 'user_id':userId,'token': token});
      await NetworkClient.instance!.dio
          .post('$adminBaseUrl/api/push-notifications/updateDeviceToken', data: formData);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
