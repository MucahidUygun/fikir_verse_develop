import 'package:fikir_verse/core/model/register_user_control.dart';
import 'package:fikir_verse/core/model/user_model.dart';
import 'package:fikir_verse/core/services/cities_services.dart';
import 'package:fikir_verse/core/services/register_user.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'register_view_model.g.dart';

class RegisterViewModel = _RegisterViewModelBase with _$RegisterViewModel;

abstract class _RegisterViewModelBase with Store {
  @observable
  UserModel? userModel;
  @observable
  TextEditingController userName = TextEditingController();
  @observable
  TextEditingController userSurname = TextEditingController();
  @observable
  TextEditingController userEmail = TextEditingController();
  @observable
  TextEditingController userPassword = TextEditingController();
  @observable
  DateTime? userBirdOfDate = DateTime(2007);
  @observable
  TextEditingController userPhoneNumber = TextEditingController();
  @observable
  TextEditingController userReferance = TextEditingController();
  

  @observable
  String cityValue = 'Seçiniz';

  @observable
  String genderValue = 'Seçiniz';

  @observable
  bool obscureText = true;

  @observable
  bool isEmailValid = false;

  @observable
  bool isClick = true;

  @observable
  String maritalStatusValue = "Seçiniz";

  @observable
  List<String> maritalStatusList = ['Seçiniz', 'Evli', 'Bekar', 'Ayrı'];

  @observable
  List<String> cityListValue = [
    'Seçiniz',
  ];

  @observable
  List<String> genderList = ["Seçiniz", 'Kadın', 'Erkek', 'Diğer'];

  @observable
  String workingStatus = "Seçiniz";

  @observable
  List<String> workingStatusList = [
    'Seçiniz',
    'Ev Hanımı',
    'Öğrenci',
    'İşsiz',
    'Çalışan'
  ];

  @observable
  bool isSelectCheckBox = false;

  /*@observable
  PDFDocument? document;

  @action
  downloadKvkk() async {
    document  =  await PDFDocument.fromURL('https://admin.fikirverse.com/upload/contracts/855186896-sqlNotlar.pdf') ;
  }*/

  @action
  void changeSelectBox() {
    isSelectCheckBox = !isSelectCheckBox;
  }

  @action
  downloadCity() async {
    cityListValue += await CitiesServices.getcities();
  }

  @action
  uptadeWorkingStatus(String? newValue) {
    newValue != null ? workingStatus = newValue : workingStatus;
  }

  @action
  uptadeMaritalStatus(String? newValue) {
    newValue != null ? maritalStatusValue = newValue : maritalStatusValue;
  }

  @action
  uptadeGender(String? newValue) {
    newValue != null ? genderValue = newValue : genderValue;
  }

  @action
  uptadeCityValue(String? newValue) {
    newValue != null ? cityValue = newValue : cityValue;
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
  changeObscure() {
    if (obscureText == true) {
      obscureText = false;
    } else {
      obscureText = true;
    }
  }

  @action
  String monthToChange() {
    if (userBirdOfDate!.month < 10) {
      return '0${userBirdOfDate!.month}';
    } else {
      return userBirdOfDate!.month.toString();
    }
  }

  @action
  changeIsClick() {
    isClick = !isClick;
  }

  @action
  registerUser() async {
    RegisterUserControl control;
    control = await RegisterUser.createUser(
        userName.text,
        userSurname.text,
        userEmail.text,
        userPassword.text,
        "${userBirdOfDate?.year}-${userBirdOfDate?.month}-${userBirdOfDate?.day}",
        userPhoneNumber.text,
        cityValue,
        genderValue,
        maritalStatusValue,
        workingStatus,
        userReferance.text
        );
    return control;
  }
}
