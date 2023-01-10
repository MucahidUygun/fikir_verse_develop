import 'package:fikir_verse/core/init/session_control.dart';
import 'package:fikir_verse/core/model/survey_model.dart';
import 'package:fikir_verse/core/widget/toast_message.dart';
import 'package:fikir_verse/page/home/viewModel/home_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MissedSurveyView extends StatefulWidget {
  List<MissedSurvey> missedsurvey;
  MissedSurveyView({Key? key, required this.missedsurvey,}) : super(key: key);

  @override
  State<MissedSurveyView> createState() => _MissedSurveyViewState();
}

class _MissedSurveyViewState extends State<MissedSurveyView> {
  @override
  void initState() {
    /*FirebaseMessaging.instance
        .getToken()
        .then((newToken) => {print('Token:$newToken')});*/
    fToast = FToast();
    fToast.init(context);
    sessionControl(true, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomePageViewModel homePageViewModel = HomePageViewModel();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          await checkNetworkControl(context);
          await homePageViewModel.refleshSurvey();
          setState(() {
            widget.missedsurvey = homePageViewModel.getMissedSurveys();
          });
        },
        child: widget.missedsurvey.isEmpty
            ? const Center(
                child: Text('Kaçırdığınız Anket Bulunmamaktadır!'),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: widget.missedsurvey.length,
                itemBuilder: ((context, index) {
                  return buildCardView(index, context);
                }),
              ),
      ),
    );
  }

  Card buildCardView(int index, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 25,
      shadowColor: Colors.grey.shade800,
      color: const Color(0xff37517e),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.note_alt_outlined,
              color: Colors.white,
              size: 40,
            ),
          ),
          //Proje adı ve anket adı
          Text(
            widget.missedsurvey[index].survey!.title!,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                  color: const Color(0xff47b2e4),
                  borderRadius: BorderRadius.circular(50)),
              width: MediaQuery.of(context).size.width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/image/coin.png',
                    ),
                  ),
                  Text(
                    '${widget.missedsurvey[index].survey!.positivePoint} Puan',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Kaçırdığınız Tarih: ${widget.missedsurvey[index].survey!.enddateFormatted}',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
