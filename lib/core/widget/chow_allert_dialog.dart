import 'package:fikir_verse/core/widget/button_widget.dart';
import 'package:flutter/material.dart';

Widget showAlertDialog(BuildContext context,
    {required VoidCallback cancelOnPressed,
    required String title,
    required String desc,
    required String confirmButtonTitle,
    required VoidCallback confirmOnPressed}) {


  Widget cancelButton = ButtonWigdet(
    onPressed:cancelOnPressed,
    title: 'Vazgeç',
  );

  Widget confirmButton =
      ButtonWigdet(onPressed: confirmOnPressed, title: confirmButtonTitle);

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
  
    title: Text(title),
    content: Text(desc),
    actions: [
      cancelButton,
      confirmButton,
    ],
  );

  // show the dialog
   showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
  return alert;
}
