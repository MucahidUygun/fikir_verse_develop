import 'package:fikir_verse/core/services/post_token.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> postToken() async {
  var session = await SharedPreferences.getInstance();
  String? userId = session.getString('userId');
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final fcmToken = await messaging.getToken();
  if (!(fcmToken == null || fcmToken.isEmpty)) {
    await PostToken.postToken(fcmToken, userId!);
  }
}
