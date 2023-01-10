import 'package:fikir_verse/core/model/point_action_model.dart';
import 'package:fikir_verse/core/model/uptade_user_profile_model.dart';
import 'package:fikir_verse/core/services/point_action_services.dart';
import 'package:fikir_verse/core/services/uptade_user_profile_services.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'point_action_view_model.g.dart';

class PointActionViewModel = _PointActionViewModelBase
    with _$PointActionViewModel;

abstract class _PointActionViewModelBase with Store {
  @observable
  PointActionModel? model;

  
  @observable
  UpdateUserProfileModel? userModel;

  @action
  getUserModel() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');
    userModel = await UptadeUserProfileServices.getMyProfile(userId!);
  }


  @action
  getServicesData() async {
    var session = await SharedPreferences.getInstance();
    String? userId = session.getString('userId');
    model = await PointActionServices.getPointActionFunction(userId!);
  }

}
