import 'package:dio/dio.dart';
import 'package:fikir_verse/core/init/config.dart';
import 'package:fikir_verse/core/init/network_client.dart';
import 'package:fikir_verse/core/model/register_user_control.dart';
import 'package:fikir_verse/core/model/uptade_user_profile_model.dart';

class UptadeUserProfileServices {
  static Future<UpdateUserProfileModel> getMyProfile(String userID) async {
    try {
      var response = await NetworkClient.instance!.dio
          .get('$siteBaseUrl/api/my-account/$userID/$token/getMyProfile');
      return UpdateUserProfileModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<RegisterUserControl> uptadeUserProfile(
      String userId,
      String userName,
      String userSurname,
      String userEmail,
      String userBirdOfDate,
      String userPhone,
      String userCity,
      String userGender,
      String userMaritalStatus,
      String userWorkingStatus) async {
    try {
      var formData = FormData.fromMap({
        'user_id': userId,
        'user_name': userName,
        'user_surname': userSurname,
        'user_email': userEmail,
        'user_date_of_birth': userBirdOfDate,
        'user_phone': userPhone,
        'user_city': userCity,
        'user_gender': userGender,
        'user_marital_status': userMaritalStatus,
        'user_working_status': userWorkingStatus,
        'token': token
      });
      var response = await NetworkClient.instance!.dio
          .post('$siteBaseUrl/api/my-account/updateProfile', data: formData);
      return RegisterUserControl.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
