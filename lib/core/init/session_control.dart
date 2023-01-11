import 'dart:io';

import 'package:fikir_verse/core/model/survey_model.dart';
import 'package:fikir_verse/core/model/uptade_user_profile_model.dart';
import 'package:fikir_verse/core/services/post_token.dart';
import 'package:fikir_verse/core/services/survey_services.dart';
import 'package:fikir_verse/core/services/uptade_user_profile_services.dart';
import 'package:fikir_verse/core/widget/toast_message.dart';
import 'package:fikir_verse/page/home/view/home_page.dart';
import 'package:fikir_verse/page/login/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> sessionControl(bool? _controlType, BuildContext context) async {
  await checkNetworkControl(context);
  // *1: Login olmuş bir kullanıcının kontrolü
  // ?0: Login olmamış bir kullanıcının kontrolü
  var session = await SharedPreferences.getInstance();
  String? userId = session.getString('userId');
  if (_controlType == true) {
    if (userId == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginView(),
        ),
      );
    }
    UpdateUserProfileModel model;
    model = await UptadeUserProfileServices.getMyProfile(userId!);
    if (model.userIsactive == '0' || model.userIsdelete == '1') {
      showToast('Hesabınız artık aktif değil!', const Color(0xfff1556c), 3,
          Icons.close, context);
      session.clear();
      Future.delayed(const Duration(seconds: 3)).then(
        (value) => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const LoginView(),
          ),
        ),
      );
    }
  } else if (_controlType == false) {
    if (userId != null) {
      SurveyModel? surveyModel = await getSurveys(userId);
      int point = await getUserModel(userId);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              HomePage(surveyModel: surveyModel!,point: point),
        ),
      );
    }
  } else {
    if (userId == null) {
      session.clear();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginView(),
        ),
      );
    } else {
      UpdateUserProfileModel model;
      model = await UptadeUserProfileServices.getMyProfile(userId);
      if (model.userIsactive == '0' || model.userIsdelete == '1') {
        showToast('Hesabınız artık aktif değil!', const Color(0xfff1556c), 3,
            Icons.close, context);
        session.clear();
        Future.delayed(const Duration(seconds: 3)).then(
          (value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => const LoginView(),
            ),
          ),
        );
      }
      SurveyModel? surveyModel = await getSurveys(userId);
      int point = await getUserModel(userId);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>
              HomePage(surveyModel: surveyModel!,point: point),
        ),
      );
    }
  }
}


  getUserModel(String userId) async {
    UpdateUserProfileModel model = await UptadeUserProfileServices.getMyProfile(userId);
    return model.point;
  }

Future<void> checkNetworkControl(BuildContext context,
    {bool? isSplashView}) async {
  try {
    await InternetAddress.lookup('google.com');
  } on SocketException catch (_) {
    if (isSplashView == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const LoginView(),
        ),
      );
    } else {
      showToast('İnternetinizi kontrol ediniz!', const Color(0xfff1556c), 3,
          Icons.close, context);
      Future.delayed(const Duration(seconds: 3)).then((value) => exit(0));
    }
  }
}

Future<SurveyModel?> getSurveys(String userID) async {
  SurveyModel? surveyModel = await SurveyServices.getSurvey(userID);
  return surveyModel;
}
