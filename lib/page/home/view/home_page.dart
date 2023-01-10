import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/init/session_control.dart';
import '../../../core/model/survey_model.dart';
import '../../../core/widget/app_bar_widget.dart';
import '../../../core/widget/side_menu.dart';
import '../viewModel/home_page_view_model.dart';
import 'surveyView/attended_surveys.dart';
import 'surveyView/missed_surveys.dart';
import 'surveyView/will_join_surveys.dart';

class HomePage extends StatefulWidget {
  final SurveyModel surveyModel;
  final int? point;
  const HomePage({Key? key, required this.surveyModel,required this.point}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomePageViewModel _viewModel = HomePageViewModel();
  @override
  initState() {
    /*FirebaseMessaging.instance
        .getToken()
        .then((newToken) => {print('Token:$newToken')});*/
    sessionControl(true, context);
    _viewModel.getUserModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(context.width, context.heightAppBar),
          child: Observer(builder: (_) {
            return BuildAppBar(
              title: 'Anketlerim',
              isShowPoint: true,
              userPoint: _viewModel.model?.point,
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: 'Katılacaklarım',
                  ),
                  Tab(
                    text: 'Katıldıklarım',
                  ),
                  Tab(
                    text: 'Kaçırdıklarım',
                  ),
                ],
              ),
            );
          }),
        ),
        drawer: const SideMenu(),
        body: TabBarView(
          children: [
            WillJoinSurveyView(
                willJoinSurvey: widget.surveyModel.willJoinSurveys!,point: widget.point),
            AttendedSurveyView(
                attendedSurvey: widget.surveyModel.attendedSurveys!),
            MissedSurveyView(missedsurvey: widget.surveyModel.missedSurveys!),
          ],
        ),
      ),
    );
  }
}
