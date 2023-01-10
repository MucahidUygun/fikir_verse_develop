import 'package:fikir_verse/core/model/register_user_control.dart';
import 'package:fikir_verse/core/model/uptade_user_profile_model.dart';
import 'package:fikir_verse/core/services/uptade_user_profile_services.dart';
import 'package:fikir_verse/core/services/user_login.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  @observable
  TextEditingController emailController = TextEditingController();
  @observable
  TextEditingController passwordController = TextEditingController();

  @observable
  bool obscureText = true;

  @observable
  bool isEmailValid = false;

  @observable
  UpdateUserProfileModel? model;

  @action
  changeObscure() {
    if (obscureText == true) {
      obscureText = false;
    } else {
      obscureText = true;
    }
  }

  @action
  String? changeEmailValid(bool isValid) {
    isEmailValid = isValid;
    if (isValid == true) {
      return null;
    } else {
      return 'Lütfen geçerli bir e-posta giriniz.';
    }
  }

  @action
  loginUser() async {
    RegisterUserControl control;
    control = await LoginUser.loginUser(
        emailController.text, passwordController.text);
    return control;
  }
  @action
  getUserModel(String userId) async {
    model = await UptadeUserProfileServices.getMyProfile(userId);
  }

  
}
