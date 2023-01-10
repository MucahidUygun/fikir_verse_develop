import 'package:fikir_verse/core/widget/button_widget.dart';
import 'package:fikir_verse/core/widget/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

Widget addPaymentDialog(
  BuildContext context, {
  required TextEditingController pointController,
  required VoidCallback confirmOnPressed,
  required VoidCallback cancelOnPressed,
}) {
  Widget cancelButton = ButtonWigdet(onPressed: cancelOnPressed, title: 'Vazgeç');

  Widget confirmButton =
      ButtonWigdet(onPressed: confirmOnPressed, title: 'Gönder');

  var maskFormatter = MaskTextInputFormatter(
      mask: '####################',
      filter: {"#": RegExp(r'[0-9]')},
      type: MaskAutoCompletionType.lazy);


  AlertDialog dialog = AlertDialog(
    title: const Text('Ödeme Talebi'),
    content: AspectRatio(
      aspectRatio: 16 / 9,
      child: InputWidget(
        inputType: [
          maskFormatter
        ],
        keyboard: TextInputType.number,
        textEditingController: pointController,
        titleName: 'Talep Ettiğiniz Puan',
        hintText: '100 puan = 1 TL',
      ),
    ),
    actions: [
      cancelButton,
      confirmButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  );
  return dialog;
}
