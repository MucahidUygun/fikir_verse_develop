import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/init/session_control.dart';
import '../../../core/model/register_user_control.dart';
import '../../../core/model/survey_model.dart';
import '../../../core/widget/button_widget.dart';
import '../../../core/widget/input_widget.dart';
import '../../../core/widget/toast_message.dart';
import '../../forgotPassword/view/forgot_password_view.dart';
import '../../home/view/home_page.dart';
import '../../register/view/register_view.dart';
import '../viewModel/login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _loginViewModel = LoginViewModel();

  @override
  void initState() {
    sessionControl(false, context);
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    ? _loginViewModel.changeEmailValid(true)
                    : _loginViewModel.changeEmailValid(false),
                titleName: "E-posta",
                hintText: 'ornek@example.com',
                keyboard: TextInputType.emailAddress,
                textEditingController:
                    _loginViewModel.emailController //_viewModel.email),
                ),
          ),
          Observer(
            builder: (_) {
              return InputWidget(
                  titleName: "Şifre",
                  hintText: 'Şifre',
                  visible: IconButton(
                    icon: _loginViewModel.obscureText == true
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    onPressed: () {
                      _loginViewModel.changeObscure();
                    },
                  ),
                  obscureText: _loginViewModel.obscureText,
                  textEditingController:
                      _loginViewModel.passwordController //_viewModel.password
                  );
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Giriş yap butonu
              ButtonWigdet(
                  color: const Color(0xff47b2e4),
                  icons: Icons.login,
                  onPressed: () async {
                    await checkNetworkControl(context);
                    if (_loginViewModel.isEmailValid == false) {
                      showToast('Lütfen geçerli bir e-posta giriniz.',
                          Colors.redAccent, 3, Icons.close, context);
                    } else {
                      RegisterUserControl _response =
                          await _loginViewModel.loginUser();
                      if (_response.status != true) {
                        showToast(_response.error?.message ?? '',
                            Colors.redAccent, 3, Icons.close, context);
                      } else {
                        var session = await SharedPreferences.getInstance();
                        session.setString('userId', _response.id!);
                        session.setString('fullName', _response.fullName!);
                        session.setString(
                            'id_encrypted', _response.idEncrypted!);
                        SurveyModel? surveyModel =
                            await getSurveys(_response.id!);
                        await _loginViewModel.getUserModel(_response.id!);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(
                                    surveyModel: surveyModel!,
                                    point: _loginViewModel.model!.point,
                                  )),
                        );
                      }
                    }
                  },
                  title: 'Giriş Yap'),
              //Kayıt Ol butonu
              ButtonWigdet(
                  onPressed: () async {
                    await checkNetworkControl(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) =>
                            RegisterView(fToast: fToast),
                      ),
                    );
                  },
                  title: 'Bir hesabınız yok mu? Kayıt olun.'),
            ],
          ),
          TextButton(
            onPressed: () async {
              await checkNetworkControl(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ForgotPasswordView(
                            fToast: fToast,
                          )));
            },
            child: Text('Şifremi unuttum?'),
          )
        ],
      ),
    );
  }
}
