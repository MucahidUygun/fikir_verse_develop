import 'package:fikir_verse/core/model/change_password_model.dart';
import 'package:fikir_verse/core/model/uptade_user_profile_model.dart';
import 'package:fikir_verse/core/services/change_password_services.dart';
import 'package:fikir_verse/core/services/uptade_user_profile_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'change_password_view_model.g.dart';

class ChangePasswordViewModel = _ChangePasswordViewModelBase
    with _$ChangePasswordViewModel;

abstract class _ChangePasswordViewModelBase with Store {
  @observable
  TextEditingController currentPassword = TextEditingController();
  @observable
  TextEditingController userPassword = TextEditingController();
  @observable
  TextEditingController userPasswordAgain = TextEditingController();

  @observable
  bool currentPasswordObscureText = true;

  @observable
  bool userPasswordObscureText = true;

  @observable
  bool userPasswordAgainObscureText = true;

  @observable
  UpdateUserProfileModel? model;

  @observable
  bool isClick= true;

  @action
   changeIsClick() {
    isClick = !isClick;
  }

  @action
  getUserModel() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');
    model = await UptadeUserProfileServices.getMyProfile(userId!);
  }

  @action
  currentPasswordChangeObscure() {
    if (currentPasswordObscureText == true) {
      currentPasswordObscureText = false;
    } else {
      currentPasswordObscureText = true;
    }
  }

  @action
  userPasswordChangeObscure() {
    if (userPasswordObscureText == true) {
      userPasswordObscureText = false;
    } else {
      userPasswordObscureText = true;
    }
  }

  @action
  userPasswordAgainChangeObscure() {
    if (userPasswordAgainObscureText == true) {
      userPasswordAgainObscureText = false;
    } else {
      userPasswordAgainObscureText = true;
    }
  }

  @action
  bool checkNewPassword() {
    if (userPassword.text != userPasswordAgain.text) {
      return true;
    } else {
      return false;
    }
  }

  @action
  Future<ChangePasswordModel> pushPassword() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');
    ChangePasswordModel model = await ChangePasswordServices.checkPassword(
        userId!,
        currentPassword.text,
        userPassword.text,
        userPasswordAgain.text);
    return model;
  }

  @action
  bool chechInputBox() {
    if (currentPassword.text.isEmpty ||
        userPassword.text.isEmpty ||
        userPasswordAgain.text.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  @action
  clearTextController() {
    currentPassword.clear();
    userPasswordAgain.clear();
    userPassword.clear();
  }
}
