import 'package:fikir_verse/core/init/session_control.dart';
import 'package:fikir_verse/core/model/survey_model.dart';
import 'package:fikir_verse/core/model/uptade_user_profile_model.dart';
import 'package:fikir_verse/core/services/uptade_user_profile_services.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'home_page_view_model.g.dart';

class HomePageViewModel = _HomePageViewModelBase with _$HomePageViewModel;

abstract class _HomePageViewModelBase with Store {
  @observable
  SurveyModel? surveyModel;
  @observable
  List<AttendedSurvey>? attendedSurvey;
  @observable
  List<WillJoinSurvey>? willJoinSurvey;
  @observable
  List<MissedSurvey>? missedSurvey;


  @observable
  bool isNotClick = false;

  @action
  changeIsNotClick() {
  isNotClick = !isNotClick;  
  }

  @action
  refleshSurvey() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');
    surveyModel = await getSurveys(userId!);
    attendedSurvey = surveyModel!.attendedSurveys;
    willJoinSurvey = surveyModel!.willJoinSurveys;
    missedSurvey = surveyModel!.missedSurveys;
  }
  /*@action
   uptadeAttendedSurvey(List<AttendedSurvey> _attendedSurvey) {
    attendedSurvey = _attendedSurvey;
  }*/

  @action
  List<AttendedSurvey> getAttendedSurvey() {
    return attendedSurvey!;
  }
  @observable
  UpdateUserProfileModel? model;

  @action
  getUserModel() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');
    model = await UptadeUserProfileServices.getMyProfile(userId!);
  }

 /* @action
   uptadeMissedSurveys(List<MissedSurvey> _missedSurveys) {
    missedSurvey= _missedSurveys;
  }*/
  @action
  List<MissedSurvey> getMissedSurveys() {
    return missedSurvey!;
  }

  /*@action
   uptadeWillJoinSurveys(List<WillJoinSurvey> _willJoinSurveys) {
  willJoinSurvey= _willJoinSurveys;  
  }*/

  @action
  List<WillJoinSurvey> getWillJoinSurveys() {
    return willJoinSurvey!;
  }
}
