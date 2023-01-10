import 'package:fikir_verse/core/init/network_client.dart';

class CitiesServices {
  static Future<List<String>> getcities() async {
    try {
      var response = await NetworkClient.instance!.dio.get('https://fikirverse.com/api/city/getAllCity');
      List<String> responseList = response.data['cities'].cast<String>();
      return responseList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}