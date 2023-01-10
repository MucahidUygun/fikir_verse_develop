import 'package:dio/dio.dart';
import 'package:fikir_verse/core/init/config.dart';
import 'package:fikir_verse/core/init/network_client.dart';
import 'package:fikir_verse/core/model/bank_info_delete_model.dart';
import 'package:fikir_verse/core/model/get_bank_info_model.dart';
import 'package:fikir_verse/core/model/post_bank_info.dart';

class BankInfoServices {
  static Future<GetBankInfoModel> getBankInfo(String userId) async {
    try {
      var response = await NetworkClient.instance!.dio
          .get('$siteBaseUrl/api/my-account/$userId/$token/getMyBankInfo');
      return GetBankInfoModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<PostBankInfoModel> postBankInfo(
      String userId,
      String bankName,
      String bankUserSurname,
      String bankBranchCode,
      String accountNumber,
      String numberTC,
      String iban) async {
    try {
      var formData = FormData.fromMap({
        'bank_name': bankName,
        'bank_user_name': bankUserSurname,
        'bank_branch_code': bankBranchCode,
        'bank_account_number': accountNumber,
        'bank_iban': iban,
        'user_id': userId,
        'bank_identity_number': numberTC,
        'token': token
      });
      var response = await NetworkClient.instance!.dio
          .post('$siteBaseUrl/api/my-account/updateBankInfo', data: formData);
      return PostBankInfoModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<BankInfoDeleteModel> deleteBankInfo(String userId) async {
    try {
      var formData = FormData.fromMap({'user_id': userId, 'token': token});
      var response = await NetworkClient.instance!.dio
          .post('$siteBaseUrl/api/my-account/deleteBankInfo', data: formData);
      return BankInfoDeleteModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
