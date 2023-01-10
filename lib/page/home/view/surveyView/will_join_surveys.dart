import 'package:fikir_verse/core/init/config.dart';
import 'package:fikir_verse/core/init/session_control.dart';
import 'package:fikir_verse/core/model/survey_model.dart';
import 'package:fikir_verse/core/model/webview_model.dart';
import 'package:fikir_verse/core/services/webview_services.dart';
import 'package:fikir_verse/core/widget/toast_message.dart';
import 'package:fikir_verse/core/widget/webview_widget.dart';
import 'package:fikir_verse/page/extraInfo/view/extra_info_view.dart';
import 'package:fikir_verse/page/home/viewModel/home_page_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class WillJoinSurveyView extends StatefulWidget {
  List<WillJoinSurvey> willJoinSurvey;
  final int? point;
  WillJoinSurveyView(
      {Key? key, required this.willJoinSurvey, required this.point})
      : super(key: key);

  @override
  State<WillJoinSurveyView> createState() => _WillJoinSurveyViewState();
}

class _WillJoinSurveyViewState extends State<WillJoinSurveyView> {
  HomePageViewModel homePageViewModel = HomePageViewModel();

  _launchURL({required String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    /*FirebaseMessaging.instance
        .getToken()
        .then((newToken) => {print('Token:$newToken')});*/
    sessionControl(true, context);
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        child: widget.willJoinSurvey.isEmpty
            ? const Center(
                child: Text('Katılacağınız Anket Bulunmamaktadır!'),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: widget.willJoinSurvey.length,
                itemBuilder: ((context, index) {
                  return widget.willJoinSurvey[index].survey!
                              .isProfileCompleteCard ==
                          true
                      ? Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 25,
                          shadowColor: Colors.grey.shade800,
                          color: const Color(0xffff8800),
                          child: InkWell(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ExtraInfoView(
                                    point: widget.point!,
                                  ),
                                ),
                              );
                            },
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
                                  widget.willJoinSurvey[index].survey!.title!,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    decoration: BoxDecoration(
                                        color: const Color(0xff47b2e4),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset(
                                            'assets/image/coin.png',
                                          ),
                                        ),
                                        Text(
                                          '${widget.willJoinSurvey[index].survey!.positivePoint} Puan',
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 25,
                          shadowColor: Colors.grey.shade800,
                          color: const Color(0xff37517e),
                          child: Observer(builder: (_) {
                            return AbsorbPointer(
                              absorbing: homePageViewModel.isNotClick,
                              child: InkWell(
                                onTap: () async {
                                  homePageViewModel.changeIsNotClick();
                                  var session =
                                      await SharedPreferences.getInstance();
                                  String? userId = session.getString('userId');
                        
                                  
                                  WebViewModel webViewModel =
                                      await WebViewServices.postSurveyControl(
                                          userId!,
                                          widget.willJoinSurvey[index].survey!
                                              .id!);
                                  if (webViewModel.status) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            WebViewWidget(
                                                url: webViewModel
                                                    .message.surveyUrl!),
                                      ),
                                    );
                                  } else {
                                    showToast(
                                        webViewModel.message.message,
                                        Colors.redAccent,
                                        5,
                                        Icons.close,
                                        context);
                                  }
                                  homePageViewModel.changeIsNotClick();
                                },
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
                                      widget
                                          .willJoinSurvey[index].survey!.title!,
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        decoration: BoxDecoration(
                                            color: const Color(0xff47b2e4),
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                'assets/image/coin.png',
                                              ),
                                            ),
                                            Text(
                                              '${widget.willJoinSurvey[index].survey!.positivePoint} Puan',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Katılım Tarihi: ${widget.willJoinSurvey[index].survey!.startdateFormatted}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Son Katılım Tarihi: ${widget.willJoinSurvey[index].survey!.enddateFormatted}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                }),
              ),
        onRefresh: () async {
          checkNetworkControl(context);
          await homePageViewModel.refleshSurvey();
          setState(() {
            widget.willJoinSurvey = homePageViewModel.getWillJoinSurveys();
          });
        },
      ),
    );
  }
}

/*SizedBox(
                      height: MediaQuery.of(context).size.height*0.3,
                      child: ListTile(
                        trailing: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          width: MediaQuery.of(context).size.width * 0.40,
                          height: MediaQuery.of(context).size.height * 0.05,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '${widget.willJoinSurvey[index].survey!.startdateFormatted}',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Text(
                                  '${widget.willJoinSurvey[index].survey!.enddateFormatted}',
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        leading: const SizedBox(
                          height: double.infinity,
                          child: Icon(
                            Icons.note_alt_rounded,
                          ),
                        ),
                        title: Text(widget.willJoinSurvey[index].survey!.title!),
                        subtitle:
                            Text(widget.willJoinSurvey[index].project!.title!),
                        onTap: () async {
                          var session = await SharedPreferences.getInstance();
                          String? idEncryptedUser =
                              session.getString('id_encrypted');
                          String url =
                              '${siteBaseUrl}survey-access?survey=${widget.willJoinSurvey[index].survey!.idEncrypted}&isMobile=true&k=$idEncryptedUser';
                          _launchURL(url: url);
                        },
                      ),
                    ), */