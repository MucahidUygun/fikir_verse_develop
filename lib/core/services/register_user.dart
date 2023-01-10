import 'package:dio/dio.dart';
import 'package:fikir_verse/core/init/network_client.dart';
import 'package:fikir_verse/core/init/config.dart';
import 'package:fikir_verse/core/model/register_user_control.dart';

class RegisterUser {
  static Future<RegisterUserControl> createUser(
      String userName,
      String userSurname,
      String userEmail,
      String userPassword,
      String userBirdOfDate,
      String userPhone,
      String userCity,
      String userGender,
      String userMaritalStatus,
      String userWorkingStatus,
      String? userReferance
      ) async {
    try {
      var formData = FormData.fromMap({
          'user_name': userName,
          'user_surname': userSurname,
          'user_email': userEmail,
          'user_password': userPassword,
          'user_date_of_birth': userBirdOfDate,
          'user_phone': userPhone,
          'user_city': userCity,
          'user_gender': userGender,
          'user_marital_status': userMaritalStatus,
          'user_working_status': userWorkingStatus,
          'user_reference' : userReferance,
          'token': token
      });
      var response = await NetworkClient.instance!.dio.post(
        '${siteBaseUrl}api/auth/register',
        data: formData
      );
      return RegisterUserControl.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
