import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

FToast fToast = FToast();

Future<bool> showToast(String message, Color colors, int second, IconData iconData,BuildContext context) async {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: colors,
    ),
    child: Wrap(
      children: [
        Center(child: Icon(iconData, color: Colors.white)),
        const SizedBox(
          width: 12.0,
        ),
        Align(
          alignment: Alignment.center,
          child: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
              ),
          ),
        ),
      ],
    ),
  ); fToast.showToast (
    fadeDuration: 100,
    child: toast,
    gravity: ToastGravity.CENTER,
    toastDuration: Duration(seconds: second),
  );
  return true;



  // Custom Toast Position
  /*fToast.showToast(
        child: toast,
        toastDuration: Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );
        });*/
}
