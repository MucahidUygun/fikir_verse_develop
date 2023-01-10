import 'package:fikir_verse/core/init/config.dart';
import 'package:fikir_verse/core/init/network_client.dart';
import 'package:fikir_verse/core/model/point_action_model.dart';

class PointActionServices {
  static Future<PointActionModel> getPointActionFunction(String userId) async {
    try {
      var response =await NetworkClient.instance!.dio
          .get('$siteBaseUrl/api/my-account/$userId/$token/getMyPointActions');
          return PointActionModel.fromJson(response.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
