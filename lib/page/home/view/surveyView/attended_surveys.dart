import 'package:fikir_verse/core/init/session_control.dart';
import 'package:fikir_verse/core/model/survey_model.dart';
import 'package:fikir_verse/page/home/viewModel/home_page_view_model.dart';
import 'package:flutter/material.dart';

class AttendedSurveyView extends StatefulWidget {
  List<AttendedSurvey> attendedSurvey;
  AttendedSurveyView({Key? key,required this.attendedSurvey}) : super(key: key);

  @override
  State<AttendedSurveyView> createState() => _AttendedSurveyViewState();
}

class _AttendedSurveyViewState extends State<AttendedSurveyView> {
  @override
  void initState() {
    /*FirebaseMessaging.instance
        .getToken()
        .then((newToken) => {print('Token:$newToken')});*/
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
            widget.attendedSurvey = homePageViewModel.getAttendedSurvey();
          });
        },
        child: widget.attendedSurvey.isEmpty
        ?const Center(child: Text('Katıldığınız Anket Bulunmamaktadır!'),) 
        :ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: widget.attendedSurvey.length,
                itemBuilder: ((context, index) {
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
                          widget.attendedSurvey[index].survey!.title!,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
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
                                  '${widget.attendedSurvey[index].surveyAttendedInfo!.pointPoint} Puan',
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Katıldığım Tarih: ${widget.attendedSurvey[index].surveyAttendedInfo!.pointCreatetimeFormatted}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
      ),
    );
  }
}
