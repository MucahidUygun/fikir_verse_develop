import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/init/session_control.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/input_widget.dart';
import '../../../core/widget/toast_message.dart';
import '../../login/view/login_view.dart';
import '../viewModel/forgot_password_view_model.dart';

class ForgotPasswordView extends StatefulWidget {
  final FToast? fToast;
  const ForgotPasswordView({Key? key, required this.fToast}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordView> {
  final ForgotPasswordViewModel _viewModel = ForgotPasswordViewModel();

  @override
  void initState() {
    sessionControl(false, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(color: Color(0xff37517e)),
              child: Image.asset('assets/image/logo.png')),
          Form(
            autovalidateMode: AutovalidateMode.always,
            child: InputWidget(
                validator: (value) => EmailValidator.validate(value!)
                    ? _viewModel.changeEmailValid(true)
                    : _viewModel.changeEmailValid(false),
                titleName: "E-posta",
                hintText: 'ornek@example.com',
                keyboard: TextInputType.emailAddress,
                textEditingController:
                    _viewModel.emailController //_viewModel.email),
                ),
          ),
          Observer(builder: (_) {
            return ButtonWigdet(
              title: 'Gönder',
              color: _viewModel.isClick ? const Color(0xff47b2e4) : Colors.red,
              icons: Icons.send_to_mobile,
              onPressed: () async {
                _viewModel.changeIsClick();
                await checkNetworkControl(context);
                await _viewModel.forgotPasswordPostEmail();
                if (_viewModel.model!.status == null) {
                  showToast('Bir hata oluştu!', const Color(0xfff1556c), 3,
                      Icons.close, context);
                } else if (_viewModel.model!.status == false) {
                  showToast(_viewModel.model!.message!.message!,
                      const Color(0xfff1556c), 6, Icons.close, context);
                } else {
                  showToast(
                      _viewModel.model!.message!.message!,
                      const Color.fromARGB(255, 43, 167, 48),
                      3,
                      Icons.check,
                      context);
                  _viewModel.clearEmail();
                }
                Future.delayed(const Duration(seconds: 3))
                    .then((value) => _viewModel.changeIsClick());
              },
            );
          }),
          // Giriş Butonu
          ButtonWigdet(
              onPressed: () async {
                await checkNetworkControl(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const LoginView(),
                  ),
                );
              },
              title: 'Şifrenizi hatırladınız mı? Giriş yapın.'),
        ],
      ),
    );
  }
}
