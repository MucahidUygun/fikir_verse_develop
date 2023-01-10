import 'dart:io';

import 'package:fikir_verse/core/extension/context_extension.dart';
import 'package:fikir_verse/core/init/session_control.dart';
import 'package:fikir_verse/core/model/survey_model.dart';
import 'package:fikir_verse/core/model/uptade_user_profile_model.dart';
import 'package:fikir_verse/core/services/uptade_user_profile_services.dart';
import 'package:fikir_verse/core/widget/app_bar_widget.dart';
import 'package:fikir_verse/page/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatefulWidget {
  final String url;
  const WebViewWidget({Key? key, required this.url}) : super(key: key);

  @override
  State<WebViewWidget> createState() => _WebViewWidgetState();
}

class _WebViewWidgetState extends State<WebViewWidget> {
  bool isLoading = true;

  late WebViewController _controller;

  late final UpdateUserProfileModel model;

  String? userId;
  String? userIdEncrypted;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(context.width, context.heightNormalAppBar),
        child: BuildAppBar(
          leading: IconButton(
              onPressed: () async {
                SurveyModel? surveyModel = await getSurveys(userId!);
                model = await getUserModel();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        HomePage(surveyModel: surveyModel!, point: model.point),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back)),
          title: 'Anket Katılım',
          isShowPoint: true,
        ),
      ),
      body: Stack(
        children: [
          WebView(
            onWebViewCreated: (webViewController) async {
              _controller = webViewController;
              var session = await SharedPreferences.getInstance();
              userId = session.getString('userId');
              userIdEncrypted = session.getString('id_encrypted');
              /*webViewController.runJavascript(
                  "var urlParams = new URLSearchParams(window.location.search);  var awardError = urlParams.get('error');   if(awardError=='award'){alert(1);}else {alert(2);}");*/
            },
            /*navigationDelegate: (NavigationRequest request) {
              String url = request.toString();
              print(url.substring(0,63));
              return NavigationDecision.navigate;
            },*/
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: widget.url,
            onPageFinished: (finish) {
              javaScriptUrl();
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Stack()
        ],
      ),
    );
  }

  getUserModel() async {
    UpdateUserProfileModel model =
        await UptadeUserProfileServices.getMyProfile(userId!);
    return model;
  }

  void javaScriptUrl() {
    setState(() {
      _controller.runJavascript(
          "var urlParams = new URLSearchParams(window.location.search);  var awardError = urlParams.get('error');"
                  "var redirect = urlParams.get('redirect');"
                  "if(awardError=='award')"
                  "{"
                  "window.location=redirect+'&ui=" +
              userIdEncrypted! +
              "'"
                  "}");
    });
  }
}
