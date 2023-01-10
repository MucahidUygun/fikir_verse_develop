import 'package:fikir_verse/core/init/session_control.dart';
import 'package:fikir_verse/core/model/survey_model.dart';
import 'package:fikir_verse/core/model/uptade_user_profile_model.dart';
import 'package:fikir_verse/core/services/uptade_user_profile_services.dart';
import 'package:fikir_verse/page/aboutUs/view/about_us_view.dart';
import 'package:fikir_verse/page/bankInfo/view/bank_info.dart';
import 'package:fikir_verse/page/changePassword/view/change_password.dart';
import 'package:fikir_verse/page/extraInfo/view/extra_info_view.dart';
import 'package:fikir_verse/page/home/view/home_page.dart';
import 'package:fikir_verse/page/login/view/login_view.dart';
import 'package:fikir_verse/page/paymentRequests/view/payment_requests.dart';
import 'package:fikir_verse/page/pointAction/view/point_action.dart';
import 'package:fikir_verse/page/profile/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  void initState() {
    getUserNameAndSurname();
    super.initState();
    getUserModel();
  }

  late final UpdateUserProfileModel model;

  String? name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: Drawer(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  color: Color(0xff37517e),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Column(
                children: [
                  Image.asset('assets/image/logo.png'),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      name ?? '',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: const Icon(Icons.note_alt_outlined),
                    title: const Text("Anketlerim"),
                    onTap: () async {
                      SharedPreferences sessions =
                          await SharedPreferences.getInstance();
                      String? userId = sessions.getString('userId');
                      SurveyModel? surveyModel = await getSurveys(userId!);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomePage(
                              surveyModel: surveyModel!, point: model.point),
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.supervised_user_circle_outlined,
                    ),
                    title: const Text('Profilim'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ProfileView()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.score_outlined),
                    title: const Text("Puan Hareketlerim"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PointAction()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.payments_outlined),
                    title: const Text("Ödeme Taleplerim"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentRequests()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_balance_wallet_outlined),
                    title: const Text('Banka Bilgilerim'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BankInfo()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.key_outlined),
                    title: const Text("Şifre Değiştir"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ChangePassword()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_circle_outlined),
                    title: const Text("Genel Bilgilerim"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExtraInfoView(
                                    point: model.point,
                                  )));
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.info_outlined,
                    ),
                    title: const Text('Fikirverse Nedir?'),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AboutUsView()));
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text("Çıkış Yap"),
                    onTap: () async {
                      SharedPreferences sessions =
                          await SharedPreferences.getInstance();
                      sessions.clear();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) =>const LoginView()),
                        (Route<dynamic> route) => false,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getUserNameAndSurname() async {
    var session = await SharedPreferences.getInstance();
    setState(() {
      name = session.getString('fullName');
    });
  }

  getUserModel() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');
    model = await UptadeUserProfileServices.getMyProfile(userId!);
  }
}
