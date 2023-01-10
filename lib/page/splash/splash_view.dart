import 'dart:io';

import 'package:fikir_verse/core/init/session_control.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: whichPlatform())).then((value) => {
    checkNetworkControl(context,isSplashView: true),
    sessionControl(null, context)
    });
  }

  int whichPlatform() {
    if (Platform.isAndroid){
      return 3;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff37517e),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Image.asset('assets/image/logo.png'),
        ),
      );
  }
}

