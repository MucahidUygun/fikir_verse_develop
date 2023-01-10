import 'package:fikir_verse/core/extension/radiobutton_enum.dart';
import 'package:fikir_verse/core/model/extra_info_get_model.dart';
import 'package:fikir_verse/core/model/extra_info_requests_model.dart';
import 'package:fikir_verse/core/model/uptade_user_profile_model.dart';
import 'package:fikir_verse/core/services/extra_info_services.dart';
import 'package:fikir_verse/core/services/uptade_user_profile_services.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'extra_info_view_model.g.dart';

class ExtraInfoViewModel = _ExtraInfoViewModelBase with _$ExtraInfoViewModel;

abstract class _ExtraInfoViewModelBase with Store {
  @observable
  ExtraInfoGetModel? getModel;

  @observable
  ScrollController controller1 = ScrollController();

  
  @observable
  UpdateUserProfileModel? model;

  @action
  getUserModel() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');
    model = await UptadeUserProfileServices.getMyProfile(userId!);
  }

  @action
  int checkUserPoint(int point) {
    if (model == null) {
      return point;
    } else {
      if (point > model!.point) {
        return point;
      } else {
        return model!.point;
      }
    }
  }

  @action
  updateGetModel() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');
    getModel = await ExtraInfoServices.getAllQuestions(userId!);

    if (getModel!.extraInfo1!.status == true) {
      educationStatus = educationList[getModel!.extraInfo1!.question1! + 1];
      workingStatus = workingList[getModel!.extraInfo1!.question2! + 1];
      jobStatus = jobList[getModel!.extraInfo1!.question3! + 1];
      educationStatusIndex = getModel!.extraInfo1!.question1!;
      workingStatusIndex = getModel!.extraInfo1!.question2!;
      jobStatusIndex = getModel!.extraInfo1!.question3!; 
    }
    if (getModel!.extraInfo2!.status == true) {
      livingStatus = indexToRadioButton(getModel!.extraInfo2!.question1!);
      smokeStatus = indexToRadioButton(getModel!.extraInfo2!.question2!);
      drinkStatus = indexToRadioButton(getModel!.extraInfo2!.question3!);
      howToChangeInternetStatus =
          indexToRadioButton(getModel!.extraInfo2!.question4!);
      haveCarStatus = indexToRadioButton(getModel!.extraInfo2!.question5!);
      haveChildStatus = indexToRadioButton(getModel!.extraInfo2!.question6!);
      havePet = indexToRadioButton(getModel!.extraInfo2!.question7!);
      bankStatus = indexToRadioButton(getModel!.extraInfo2!.question8!);
      howInternet = indexToRadioButton(getModel!.extraInfo2!.question9!);
      for (var item in getModel!.extraInfo2!.question10!.answers) {
        changeIsSelect1(true, item);
      }
      for (var item in getModel!.extraInfo2!.question11!.answers) {
        changeIsSelect2(true, item);
      }
      for (var item in getModel!.extraInfo2!.question12!.answers) {
        changeIsSelect3(true, item);
      }
      for (var item in getModel!.extraInfo2!.question13!.answers) {
        changeIsSelect4(true, item);
      }
      for (var item in getModel!.extraInfo2!.question14!.answers) {
        changeIsSelect5(true, item);
      }
      for (var item in getModel!.extraInfo2!.question15!.answers) {
        changeIsSelect6(true, item);
      }
    }
  }

  @action
  bool isHave() {
    if (livingStatus == null ||
        smokeStatus == null ||
        drinkStatus == null ||
        howToChangeInternetStatus == null ||
        haveCarStatus == null ||
        haveChildStatus == null ||
        havePet == null ||
        bankStatus == null ||
        howInternet == null ||
        selectedAnswers1 == [] ||
        selectedAnswers2 == [] ||
        selectedAnswers3 == [] ||
        selectedAnswers4 == [] ||
        selectedAnswers5 == [] ||
        selectedAnswers6 == []) {
      return false;
    } else {
      return true;
    }
  }

  @observable
  ExtraInfoRequestsModel? usageHabitsRequestsModel;


  @action
  postUsageHabits() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');



    usageHabitsRequestsModel = await ExtraInfoServices.postUsageHabits(
        userId!,
        livingStatus?.index,
        smokeStatus?.index,
        drinkStatus?.index,
        howToChangeInternetStatus?.index,
        haveCarStatus?.index,
        haveChildStatus?.index,
        havePet?.index,
        bankStatus?.index,
        howInternet?.index,
        selectedAnswers1,
        selectedAnswers2,
        selectedAnswers3,
        selectedAnswers4,
        selectedAnswers5,
        selectedAnswers6);
  }

  @action
  RadioButtonEnum? indexToRadioButton(int index) {
    switch (index) {
      case 0:
        return RadioButtonEnum.option0;
      case 1:
        return RadioButtonEnum.option1;
      case 2:
        return RadioButtonEnum.option2;
      case 3:
        return RadioButtonEnum.option3;
      case 4:
        return RadioButtonEnum.option4;
      case 5:
        return RadioButtonEnum.option5;
      case 6:
        return RadioButtonEnum.option6;
      case 7:
        return RadioButtonEnum.option7;
      case 8:
        return RadioButtonEnum.option8;
      case 9:
        return RadioButtonEnum.option9;
      case 10:
        return RadioButtonEnum.option10;
      case 11:
        return RadioButtonEnum.option11;
      case 12:
        return RadioButtonEnum.option12;
      case 13:
        return RadioButtonEnum.option13;
      default:
        return null;
    }
  }

  @observable
  String educationStatus = 'Seçiniz';

  @observable
  int? educationStatusIndex;

  List<String> educationList = [
    'Seçiniz',
    'Yüksek Lisans/Doktara',
    'Üniversite(4 yıllık)',
    'Yüksekokul',
    'Açık Ögretim (2-4 yıllık)',
    'Lise',
    'Ortaokul',
    'İlkokul'
  ];

  @observable
  String workingStatus = 'Seçiniz';

  @observable
  List<String> workingList = [
    'Seçiniz',
    'Tam zamanlı çalışıyorum',
    'Yarı zamanlı (part time) çalışıyorum',
    'Şu anda çalışmıyorum, iş arıyorum',
    'Öğrenciyim',
    'Ev hanımıyım',
    'Emekliyim'
  ];

  @observable
  int? workingStatusIndex;

  @action
  updateWorking(String? value) {
    value != null ? workingStatus = value : workingStatus == 'Seçiniz';
    for (int i = 0; i < workingList.length; i++) {
      if (workingStatus == workingList[i]) {
        if (i > 0) {
          workingStatusIndex = i - 1;
        }
      }
    }
  }

  @action
  updateJob(String? value) {
    value != null ? jobStatus = value : jobStatus == 'Seçiniz';
    for (int i = 0; i < jobList.length; i++) {
      if (jobStatus == jobList[i]) {
        if (i > 0) {
          jobStatusIndex = i - 1;
        }
      }
    }
  }

  @action
  updateEducation(String? value) {
    value != null ? educationStatus = value : educationStatus == 'Seçiniz';
    for (int i = 0; i < educationList.length; i++) {
      if (educationStatus == educationList[i]) {
        if (i > 0) {
          educationStatusIndex = i - 1;
        }
      }
    }
  }

  @observable
  String jobStatus = 'Seçiniz';

  @observable
  int? jobStatusIndex;

  @observable
  List<String> jobList = [
    'Seçiniz',
    'Nitelikli serbest meslek sahibi',
    '0-5 çalışanlı tüccar',
    '6-20 çalışanlı tüccar',
    '20 + çalışanlı tüccar',
    '1-9 çalışanlı şirket',
    '10-25 çalışanlı şirket',
    '25 + çalışanlı şirket',
    'Üst düzey yönetici',
    "10'dan az çalışanlı orta düzey yönetici",
    "10'dan fazla çalışanlı orta düzey yönetici",
    "Nitelikli uzman, mühendis, teknik eleman",
    "Memur/ofis çalışanı",
    "İşçi/Hizmetli",
  ];

  @observable
  PageController pageController = PageController(initialPage: 0);

  @observable
  RadioButtonEnum? livingStatus;

  @action
  updateLiving(RadioButtonEnum? value) {
    livingStatus = value;
  }

  @observable
  RadioButtonEnum? smokeStatus;

  @action
  updateSmoke(RadioButtonEnum? value) {
    smokeStatus = value;
  }

  @observable
  RadioButtonEnum? drinkStatus;

  @action
  updateDrink(RadioButtonEnum? value) {
    drinkStatus = value;
  }

  @observable
  RadioButtonEnum? howToChangeInternetStatus;

  @action
  updatehowToChangeInternetStatus(RadioButtonEnum? value) {
    howToChangeInternetStatus = value;
  }

  @observable
  RadioButtonEnum? haveChildStatus;

  @action
  updateHaveChild(RadioButtonEnum? value) {
    haveChildStatus = value;
  }

  @observable
  RadioButtonEnum? haveCarStatus;

  @action
  updateHaveCar(RadioButtonEnum? value) {
    haveCarStatus = value;
  }

  @observable
  RadioButtonEnum? howInternet;

  @action
  updateHowInternet(RadioButtonEnum? value) {
    howInternet = value;
  }

  @observable
  RadioButtonEnum? bankStatus;

  @action
  updateBankStatus(RadioButtonEnum? value) {
    bankStatus = value;
  }

  @observable
  RadioButtonEnum? havePet;

  @action
  updatePet(RadioButtonEnum? value) {
    havePet = value;
  }

  @observable
  ExtraInfoRequestsModel? modelHouse;

  @action
  updateHouseholdProfile() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');

    modelHouse = await ExtraInfoServices.postHouseProfile(
        userId!, educationStatusIndex, workingStatusIndex, jobStatusIndex);
  }

  //1. Çoklu soru için
  @observable
  List<int> selectedAnswers1 = [];
  @observable
  List<bool> isSelect1 = [false, false, false, false, false];

  @action
  changeIsSelect1(bool value, int index) {
    isSelect1[index] = value;
    value == true
        ? selectedAnswers1.add(index)
        : selectedAnswers1.remove(index);
  }

  //2. Çoklu soru için
  @observable
  List<int> selectedAnswers2 = [];
  @observable
  List<bool> isSelect2 = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @action
  changeIsSelect2(bool value, int index) {
    isSelect2[index] = value;
    value == true
        ? selectedAnswers2.add(index)
        : selectedAnswers2.remove(index);
  }

  //3. Çoklu soru için
  @observable
  List<int> selectedAnswers3 = [];
  @observable
  List<bool> isSelect3 = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @action
  changeIsSelect3(bool value, int index) {
    isSelect3[index] = value;
    value == true
        ? selectedAnswers3.add(index)
        : selectedAnswers3.remove(index);
  }

  //4. Coklu soru için
  @observable
  List<int> selectedAnswers4 = [];
  @observable
  List<bool> isSelect4 = [false, false, false, false, false, false, false];

  @action
  changeIsSelect4(bool value, int index) {
    isSelect4[index] = value;
    value == true
        ? selectedAnswers4.add(index)
        : selectedAnswers4.remove(index);
  }

  //5. Çoklu soru için
  @observable
  List<int> selectedAnswers5 = [];
  @observable
  List<bool> isSelect5 = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @action
  changeIsSelect5(bool value, int index) {
    isSelect5[index] = value;
    value == true
        ? selectedAnswers5.add(index)
        : selectedAnswers5.remove(index);
  }

  //6. çoklu soru için
  @observable
  List<int> selectedAnswers6 = [];
  @observable
  List<bool> isSelect6 = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @action
  changeIsSelect6(bool value, int index) {
    isSelect6[index] = value;
    value == true
        ? selectedAnswers6.add(index)
        : selectedAnswers6.remove(index);
  }
}
