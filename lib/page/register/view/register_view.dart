import 'package:email_validator/email_validator.dart';
import 'package:fikir_verse/core/init/session_control.dart';
import 'package:fikir_verse/core/widget/app_bar_widget.dart';
import 'package:fikir_verse/core/widget/button_widget.dart';
import 'package:fikir_verse/core/widget/check_box_button_widget.dart';
import 'package:fikir_verse/core/widget/toast_message.dart';
import 'package:fikir_verse/page/login/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import '../../../core/model/register_user_control.dart';
import '../../../core/widget/input_widget.dart';
import '../viewModel/register_view_model.dart';
import 'package:fikir_verse/core/extension/context_extension.dart';

class RegisterView extends StatefulWidget {
  final FToast fToast;
  const RegisterView({Key? key, required this.fToast}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = RegisterViewModel();
  FToast fToast = FToast();

  @override
  void initState() {
    sessionControl(false, context);
    _viewModel.downloadCity();
    super.initState();
  }

  var maskFormatter = MaskTextInputFormatter(
      mask: '(###) ###-##-##',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);

  @override
  Widget build(BuildContext context) {
    ProgressDialog pd = ProgressDialog(context: context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Observer(
        builder: (_) {
          return ButtonWigdet(
              icons: Icons.add,
              color: _viewModel.isClick ? const Color(0xff47b2e4) : Colors.red,
              onPressed: _viewModel.isClick
                  ? () async {
                      await loginOnPressed(pd, context);
                      Future.delayed(const Duration(seconds: 3)).whenComplete(
                        () => _viewModel.changeIsClick(),
                      );
                    }
                  : null,
              title: 'Kayıt ol');
        },
      ),
      backgroundColor: Colors.grey.shade300,
      appBar: PreferredSize(
        preferredSize: Size(context.width, context.heightNormalAppBar),
        child: const BuildAppBar(
          isShowPoint: false,
          title: 'Fikirverse | Kayıt Ol',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //İsim alınan input
            InputWidget(
                hintText: 'Adınız',
                titleName: "Adınız",
                textEditingController: _viewModel.userName //_viewModel.name
                ),
            //Soy isim alınan input
            InputWidget(
                hintText: 'Soyadınız',
                titleName: "Soyadınız",
                textEditingController:
                    _viewModel.userSurname //_viewModel.surname
                ),
            //Email alınan input
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
                      _viewModel.userEmail //_viewModel.email),
                  ),
            ),
            //Şifre alınan input
            Observer(builder: (_) {
              return InputWidget(
                  hintText: 'Şifre',
                  titleName: "Şifre",
                  visible: IconButton(
                    icon: _viewModel.obscureText == true
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    onPressed: () {
                      _viewModel.changeObscure();
                    },
                  ),
                  obscureText: _viewModel.obscureText,
                  textEditingController:
                      _viewModel.userPassword //_viewModel.password
                  );
            }),
            //Doğum tarihi alınan input
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 7.0, top: 8.0),
                    child: Text(
                      'Doğum Tarihi',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      DatePicker.showDatePicker(
                        context,
                        locale: LocaleType.tr,
                        showTitleActions: true,
                        minTime: DateTime(1900, 1, 1),
                        maxTime: DateTime.now(),
                        onChanged: (date) {
                          _viewModel.userBirdOfDate = date;
                        },
                        onConfirm: (date) {
                          _viewModel.userBirdOfDate = date;
                        },
                        currentTime: DateTime.now(),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: const Color.fromARGB(85, 24, 23, 23))),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Observer(builder: (_) {
                            return Text(
                              '${_viewModel.userBirdOfDate!.day}-${_viewModel.monthToChange()}-${_viewModel.userBirdOfDate!.year}',
                              style: const TextStyle(
                                  color: Colors.black87, fontSize: 16),
                            );
                          }),
                          const Icon(
                            Icons.date_range_outlined,
                            size: 35.0,
                            color: Color(0xff47b2e4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Telefon numarasının alındığı input
            InputWidget(
              hintText: '(XXX) XXX-XX-XX',
              titleName: "Telefon numaranızı giriniz",
              textEditingController: _viewModel.userPhoneNumber,
              keyboard: TextInputType.number,
              inputType: [maskFormatter],
            ),
            //Şehir için listeleme
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'Şehir',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(85, 24, 23, 23)),
                        borderRadius: BorderRadius.circular(15)),
                    child: DropdownButtonHideUnderline(
                      child: Observer(builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: DropdownButton<String>(
                            hint: Text(_viewModel.cityValue),
                            value: _viewModel.cityValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              _viewModel.uptadeCityValue(newValue);
                            },
                            items: _viewModel.cityListValue
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            //Cinsiyet için listeleme
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'Cinsiyet',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(85, 24, 23, 23)),
                        borderRadius: BorderRadius.circular(15)),
                    child: DropdownButtonHideUnderline(
                      child: Observer(builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: DropdownButton<String>(
                            value: _viewModel.genderValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              _viewModel.uptadeGender(newValue);
                            },
                            items: _viewModel.genderList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            // Medeni hal
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'Medeni Hal',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(85, 24, 23, 23)),
                        borderRadius: BorderRadius.circular(15)),
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButtonHideUnderline(
                      child: Observer(builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: DropdownButton<String>(
                            value: _viewModel.maritalStatusValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              _viewModel.uptadeMaritalStatus(newValue);
                            },
                            items: _viewModel.maritalStatusList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            //Çalışma Durumu
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'Çalışma Durumu',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromARGB(85, 24, 23, 23)),
                        borderRadius: BorderRadius.circular(15)),
                    width: MediaQuery.of(context).size.width,
                    child: DropdownButtonHideUnderline(
                      child: Observer(builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: DropdownButton<String>(
                            value: _viewModel.workingStatus,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              _viewModel.uptadeWorkingStatus(newValue);
                            },
                            items: _viewModel.workingStatusList
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),//Referans alanı
            InputWidget(
                hintText: 'Referans (opsiyonel)',
                titleName: "Referans (opsiyonel)",
                maxLength: 100,
                textEditingController: _viewModel.userReferance //_viewModel.name
                ),
            //KVKK alanı
            Observer(builder: (_) {
              return CheckBoxButtonWidget(
                isSelectCheck: _viewModel.isSelectCheckBox,
                onPressedCheckBox: () {
                  _viewModel.changeSelectBox();
                },
              );
            }),
            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }

  //Login butonuna basılınca çalışan fonksiyon
  Future<void> loginOnPressed(ProgressDialog pd, BuildContext context) async {
    await checkNetworkControl(context);
    pd.show(max: 10, msg: 'Lütfen bekleyiniz...');
    _viewModel.changeIsClick();
    if (_viewModel.isEmailValid == false) {
      pd.close();
      showToast('Lütfen geçerli bir e-posta giriniz.', Colors.redAccent, 3,
          Icons.close, context);
    } else if (!_viewModel.isSelectCheckBox) {
      pd.close();
      showToast(
          'Lütfen Kişisel Verileri Koruma Kanunu okudum, anladım olarak işaretleyiniz. ',
          Colors.redAccent,
          3,
          Icons.close,
          context);
    } else {
      RegisterUserControl _response = await _viewModel.registerUser();
      pd.close();
      if (_response.status != true) {
        showToast(_response.error?.message ?? '', Colors.redAccent, 3,
            Icons.close, context);
      } else {
        showToast(
            "Tebrikler! Kayıt işleminiz başarılı, giriş sayfasına yönlendiriyorsunuz.",
            const Color.fromARGB(255, 43, 167, 48),
            3,
            Icons.check,
            context);
        Future.delayed(const Duration(seconds: 3)).then(
          (value) => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const LoginView(),
            ),
          ),
        );
      }
    }
  }
}
