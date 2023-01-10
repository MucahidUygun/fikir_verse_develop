import 'package:fikir_verse/core/model/bank_info_delete_model.dart';
import 'package:fikir_verse/core/model/get_bank_info_model.dart';
import 'package:fikir_verse/core/model/post_bank_info.dart';
import 'package:fikir_verse/core/model/uptade_user_profile_model.dart';
import 'package:fikir_verse/core/services/bank_info_services.dart';
import 'package:fikir_verse/core/services/uptade_user_profile_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'bank_info_view_model.g.dart';

class BankInfoViewModel = _BankInfoViewModelBase with _$BankInfoViewModel;

abstract class _BankInfoViewModelBase with Store {
  @observable
  TextEditingController bankName = TextEditingController();

  @observable
  TextEditingController ibanText = TextEditingController();

  @observable
  GetBankInfoModel model = GetBankInfoModel();

  @observable
  TextEditingController accountNameSurname = TextEditingController();

  @observable
  TextEditingController branchCode = TextEditingController();

  @observable
  TextEditingController accountNumber = TextEditingController();

  @observable
  bool isShowDeleteButton = false;

  @observable
  TextEditingController numberTC = TextEditingController();


  @observable
  UpdateUserProfileModel? userModel;
  @action
  getUserModel() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');
    userModel = await UptadeUserProfileServices.getMyProfile(userId!);
  }

  @action
  clearTextController() {
    bankName.clear();
    ibanText.clear();
    accountNameSurname.clear();
    branchCode.clear();
    accountNumber.clear();
    isShowDeleteButton = false;
  }

  @action
  getBankInfoFunction() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');
    model = await BankInfoServices.getBankInfo(userId!);
    if (model.status == true) {
      bankName.text = model.bankName ?? '';
      ibanText.text = model.bankIban ?? '';
      accountNameSurname.text = model.bankUserName ?? '';
      branchCode.text = model.bankBranchCode ?? '';
      accountNumber.text = model.bankAccountNumber ?? '';
      numberTC.text = model.numberTC ?? '';
    }
    checkDeleteButton();
  }

  Future<PostBankInfoModel?> postBankInfoFunction() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');
    if (bankName.text == '' ||
        ibanText.text == '' ||
        accountNameSurname.text == '' ||
        branchCode.text == '' ||
        accountNumber.text == '') {
      return null;
    } else {
      PostBankInfoModel model = await BankInfoServices.postBankInfo(
          userId!,
          bankName.text,
          accountNameSurname.text,
          branchCode.text,
          accountNumber.text,
          numberTC.text,
          ibanText.text);
      return model;
    }
  }

  @action
  deleteBankInfoFunction() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');
    BankInfoDeleteModel model = await BankInfoServices.deleteBankInfo(userId!);
    return model;
  }

  @action
  checkDeleteButton({bool? postStatus}) {
    if (model.status == true || postStatus == true) {
      isShowDeleteButton = true;
    } else {
      isShowDeleteButton == false;
    }
  }
}
