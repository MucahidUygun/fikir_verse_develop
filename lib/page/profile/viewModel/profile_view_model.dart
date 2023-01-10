import 'package:fikir_verse/core/model/register_user_control.dart';
import 'package:fikir_verse/core/model/uptade_user_profile_model.dart';
import 'package:fikir_verse/core/model/user_model.dart';
import 'package:fikir_verse/core/services/cities_services.dart';
import 'package:fikir_verse/core/services/uptade_user_profile_services.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store {
  @observable
  RegisterUserControl? control;
  @observable
  UpdateUserProfileModel? updateUserProfileModel;
  @observable
  TextEditingController userName = TextEditingController();
  @observable
  TextEditingController userSurname = TextEditingController();
  @observable
  TextEditingController userEmail = TextEditingController();
  @observable
  DateTime? userBirdOfDate = DateTime(1900);
  @observable
  TextEditingController userPhoneNumber = TextEditingController();

  @observable
  String? cityValue;

  @observable
  String? genderValue;

  @observable
  bool obscureText = true;

  @observable
  bool isEmailValid = false;

  @observable
  bool isClick = true;

  @observable
  String? maritalStatusValue;

  @observable
  List<String> maritalStatusList = ['Seçiniz', 'Evli', 'Bekar', 'Ayrı'];

  @observable
  List<String> cityListValue = [
    'Seçiniz',
  ];
  @observable
  List<String> genderList = ["Seçiniz", 'Kadın', 'Erkek', 'Diğer'];

  @observable
  String? workingStatus;

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
  uptadeUserProfileViewModel() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');
    control = await UptadeUserProfileServices.uptadeUserProfile(
      userId!,
      userName.text,
      userSurname.text,
      userEmail.text,
      "${userBirdOfDate?.year}-${userBirdOfDate?.month}-${userBirdOfDate?.day}",
      userPhoneNumber.text,
      cityValue!,
      genderValue!,
      maritalStatusValue!,
      workingStatus!,
    );
    return control;
  }

  @action
  Future<void> getUserProfilIde() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');
    updateUserProfileModel =
        await UptadeUserProfileServices.getMyProfile(userId!);
    userName.text = updateUserProfileModel!.userName;
    userEmail.text = updateUserProfileModel!.userEmail;
    userSurname.text = updateUserProfileModel!.userSurname;
    userBirdOfDate = updateUserProfileModel!.userDateOfBirth;
    userPhoneNumber.text = updateUserProfileModel!.userPhone;
    cityValue = updateUserProfileModel!.userCity;
    genderValue = updateUserProfileModel!.userGender;
    maritalStatusValue = updateUserProfileModel!.userMaritalStatus;
    workingStatus = updateUserProfileModel!.userWorkingStatus;
  }
}
