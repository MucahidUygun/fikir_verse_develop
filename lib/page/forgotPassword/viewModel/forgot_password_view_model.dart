import 'package:fikir_verse/core/model/change_password_model.dart';
import 'package:fikir_verse/core/services/forgot_password_services.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'forgot_password_view_model.g.dart';

class ForgotPasswordViewModel = _ForgotPasswordViewModelBase
    with _$ForgotPasswordViewModel;

abstract class _ForgotPasswordViewModelBase with Store {
  
  @observable
  bool isEmailValid = false;

  @observable
  bool isClick= true;

  @action
   changeIsClick() {
    isClick = !isClick;
  }

  @observable
  TextEditingController emailController = TextEditingController();

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
  clearEmail() {
    emailController.clear();
  }

  @observable
  ChangePasswordModel? model;

  @action
  forgotPasswordPostEmail() async {
    model = await ForgotPasswordServices.forgotPasswordFunction(
        emailController.text);
  }
}
