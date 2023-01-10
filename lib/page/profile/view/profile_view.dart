import 'package:email_validator/email_validator.dart';
import 'package:fikir_verse/core/init/session_control.dart';
import 'package:fikir_verse/core/model/register_user_control.dart';
import 'package:fikir_verse/core/widget/app_bar_widget.dart';
import 'package:fikir_verse/core/widget/button_widget.dart';
import 'package:fikir_verse/core/widget/input_widget.dart';
import 'package:fikir_verse/core/widget/side_menu.dart';
import 'package:fikir_verse/core/widget/toast_message.dart';
import 'package:fikir_verse/page/profile/viewModel/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import 'package:fikir_verse/core/extension/context_extension.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final ProfileViewModel _profileViewModel = ProfileViewModel();
  FToast fToast = FToast();
  @override
  void initState() {
    _profileViewModel.getUserProfilIde();
    _profileViewModel.downloadCity();
    fToast = FToast();
    fToast.init(context);
    sessionControl(true, context);
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
      floatingActionButton:
          //Güncelle butonu
          Observer(builder: (_) {
        return ButtonWigdet(
            icons: Icons.save,
            color: _profileViewModel.isClick
                ? const Color(0xff47b2e4)
                : Colors.red,
            onPressed: _profileViewModel.isClick
                ? () async {
                    await checkNetworkControl(context);
                    await uptadeProfileButtonOnPressed(pd, context);
                    Future.delayed(const Duration(seconds: 3)).whenComplete(
                      () => _profileViewModel.changeIsClick(),
                    );
                  }
                : null,
            title: 'Güncelle');
      }),
      backgroundColor: Colors.grey.shade300,
      appBar: PreferredSize(
        preferredSize: Size(context.width, context.heightNormalAppBar),
        child: Observer(builder: (_) {
          return BuildAppBar(
            isShowPoint: true,
            title: 'Profilim',
            userPoint: _profileViewModel.updateUserProfileModel?.point,
          );
        }),
      ),
      drawer: const SideMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //İsim alınan input
            Observer(builder: (_) {
              return InputWidget(
                  hintText: _profileViewModel.userName.text,
                  titleName: "Adınız",
                  textEditingController:
                      _profileViewModel.userName //_viewModel.name
                  );
            }),
            //Soy isim alınan input
            Observer(builder: (_) {
              return InputWidget(
                  hintText: _profileViewModel.userSurname.text,
                  titleName: "Soyadınız",
                  textEditingController:
                      _profileViewModel.userSurname //_viewModel.surname
                  );
            }),
            //Email alınan input
            Form(
              autovalidateMode: AutovalidateMode.always,
              child: InputWidget(
                  validator: (value) => EmailValidator.validate(value!)
                      ? _profileViewModel.changeEmailValid(true)
                      : _profileViewModel.changeEmailValid(false),
                  titleName: "E-posta",
                  hintText: 'ornek@example.com',
                  keyboard: TextInputType.emailAddress,
                  textEditingController:
                      _profileViewModel.userEmail //_viewModel.email),
                  ),
            ),
            //Doğum tarihi alınan input
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:  EdgeInsets.only(left: 7.0, top: 8.0),
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
                          _profileViewModel.userBirdOfDate = date;
                        },
                        onConfirm: (date) {
                          _profileViewModel.userBirdOfDate = date;
                        },
                        currentTime: DateTime.now(),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding:const EdgeInsets.all(13),
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
                              _profileViewModel.userBirdOfDate ==
                                      DateTime(1900, 1, 1)
                                  ? "Lütfen doğum tarihinizi giriniz."
                                  : '${_profileViewModel.userBirdOfDate!.day}-${_profileViewModel.monthToChange()}-${_profileViewModel.userBirdOfDate!.year}',
                              style:const TextStyle(
                                color: Colors.black87,
                                  fontSize: 16),
                            );
                          }),
                         const Icon(
                            Icons.date_range_outlined,
                            size: 35.0,
                            color:  Color(0xff47b2e4),
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
              textEditingController: _profileViewModel.userPhoneNumber,
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
                            hint:
                                Text(_profileViewModel.cityValue ?? 'Şehriniz'),
                            value: _profileViewModel.cityValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              _profileViewModel.uptadeCityValue(newValue);
                            },
                            items: _profileViewModel.cityListValue
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
                            hint: Text(_profileViewModel.genderValue ??
                                'Cinsiyetiniz.'),
                            value: _profileViewModel.genderValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              _profileViewModel.uptadeGender(newValue);
                            },
                            items: _profileViewModel.genderList
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
                            hint: Text(_profileViewModel.maritalStatusValue ??
                                'Medeni durumunuz.'),
                            value: _profileViewModel.maritalStatusValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              _profileViewModel.uptadeMaritalStatus(newValue);
                            },
                            items: _profileViewModel.maritalStatusList
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
                            hint: Text(_profileViewModel.workingStatus ??
                                'Çalışma durumunuz.'),
                            value: _profileViewModel.workingStatus,
                            icon: const Icon(Icons.arrow_drop_down),
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              _profileViewModel.uptadeWorkingStatus(newValue);
                            },
                            items: _profileViewModel.workingStatusList
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> uptadeProfileButtonOnPressed(
      ProgressDialog pd, BuildContext context) async {
    await checkNetworkControl(context);
    _profileViewModel.changeIsClick();
    if (_profileViewModel.isEmailValid == false) {
      showToast('Lütfen geçerli bir e-posta giriniz.', Colors.redAccent, 3,
          Icons.close, context);
    } else {
      RegisterUserControl updateUserProfileModel =
          await _profileViewModel.uptadeUserProfileViewModel();
      if (updateUserProfileModel.status != true) {
        showToast(updateUserProfileModel.error?.message ?? '', Colors.redAccent,
            3, Icons.close, context);
      } else {
        showToast(
          updateUserProfileModel.error?.message ?? '',
          const Color.fromARGB(255, 43, 167, 48),
          3,
          Icons.check,
          context,
        );
      }
    }
  }
}
