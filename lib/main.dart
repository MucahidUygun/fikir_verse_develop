import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'page/splash/splash_view.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FikirVerse',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.amberAccent.shade400,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
