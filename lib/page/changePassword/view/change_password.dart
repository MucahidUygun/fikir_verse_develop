import 'package:fikir_verse/core/extension/context_extension.dart';
import 'package:fikir_verse/core/init/session_control.dart';
import 'package:fikir_verse/core/model/change_password_model.dart';
import 'package:fikir_verse/core/widget/app_bar_widget.dart';
import 'package:fikir_verse/core/widget/button_widget.dart';
import 'package:fikir_verse/core/widget/input_widget.dart';
import 'package:fikir_verse/core/widget/side_menu.dart';
import 'package:fikir_verse/core/widget/toast_message.dart';
import 'package:fikir_verse/page/changePassword/viewModel/change_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  ChangePasswordViewModel changePasswordViewModel = ChangePasswordViewModel();
  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    sessionControl(true, context);
    changePasswordViewModel.getUserModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(context.width, context.heightNormalAppBar),
          child: Observer(builder: (_) {
            return BuildAppBar(
              title: 'Şifre Değiştir',
              isShowPoint: true,
              userPoint: changePasswordViewModel.model?.point,
            );
          })),
      drawer: const SideMenu(),
      body: Column(
        children: [
          //current şifre
          Observer(builder: (_) {
            return InputWidget(
              hintText: 'Şifreniz',
              titleName: 'Şifreniz',
              textEditingController: changePasswordViewModel.currentPassword,
              obscureText: changePasswordViewModel.currentPasswordObscureText,
              visible: IconButton(
                icon: changePasswordViewModel.currentPasswordObscureText
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  changePasswordViewModel.currentPasswordChangeObscure();
                },
              ),
            );
          }),
          //İlk yeni şifre
          Observer(builder: (_) {
            return InputWidget(
              hintText: 'Yeni Şifreniz',
              titleName: 'Yeni Şifreniz',
              textEditingController: changePasswordViewModel.userPassword,
              obscureText: changePasswordViewModel.userPasswordObscureText,
              visible: IconButton(
                icon: changePasswordViewModel.userPasswordObscureText
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  changePasswordViewModel.userPasswordChangeObscure();
                },
              ),
            );
          }),
          // ikinci yeni şifre
          Observer(builder: (_) {
            return InputWidget(
              hintText: 'Yeni Şifreniz tekrar',
              titleName: 'Yeni Şifreniz tekrar',
              textEditingController: changePasswordViewModel.userPasswordAgain,
              obscureText: changePasswordViewModel.userPasswordAgainObscureText,
              visible: IconButton(
                icon: changePasswordViewModel.userPasswordAgainObscureText
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                onPressed: () {
                  changePasswordViewModel.userPasswordAgainChangeObscure();
                },
              ),
            );
          }),
          Observer(builder: (_) {
            return ButtonWigdet(
                icons: Icons.save,
                color: changePasswordViewModel.isClick
                    ? const Color(0xff47b2e4)
                    : Colors.red,
                onPressed: () async {
                  changePasswordViewModel.changeIsClick();
                  await checkNetworkControl(context);
                  if (changePasswordViewModel.chechInputBox()) {
                    showToast('Lütfen boş alanları doldurunuz!',
                        Colors.redAccent, 3, Icons.close, context);
                  } else {
                    if (changePasswordViewModel.checkNewPassword()) {
                      showToast('Şifreniz uyuşmuyor', Colors.redAccent, 3,
                          Icons.close, context);
                    } else {
                      ChangePasswordModel passwordModel =
                          await changePasswordViewModel.pushPassword();
                      if (passwordModel.status!) {
                        showToast(
                            passwordModel.message!.message!,
                            const Color.fromARGB(255, 43, 167, 48),
                            3,
                            Icons.check,
                            context);
                        changePasswordViewModel.clearTextController();
                      } else {
                        showToast(passwordModel.message!.message!,
                            Colors.redAccent, 3, Icons.close, context);
                      }
                    }
                  }
                  Future.delayed(const Duration(seconds: 3))
                      .then((value) => changePasswordViewModel.changeIsClick());
                },
                title: 'Şifreyi Güncelle');
          })
        ],
      ),
    );
  }
}
