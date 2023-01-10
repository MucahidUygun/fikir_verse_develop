import 'package:fikir_verse/core/init/config.dart';
import 'package:fikir_verse/core/init/network_client.dart';
import 'package:fikir_verse/core/model/kvkk_model.dart';

class KvkkServices {
  static Future<KvkkModel> getKvkk() async {
    try {
      var reponse = await NetworkClient.instance!.dio
          .get('$adminBaseUrl/api/contract/$token/getContracts');
      return KvkkModel.fromJson(reponse.data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
