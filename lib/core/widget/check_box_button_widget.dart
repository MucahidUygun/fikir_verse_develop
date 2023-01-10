import 'package:fikir_verse/core/widget/show_pdf_view.dart';
import 'package:flutter/material.dart';

class CheckBoxButtonWidget extends StatefulWidget {
  final VoidCallback onPressedCheckBox;
  final bool isSelectCheck;
  const CheckBoxButtonWidget({
    Key? key,
    required this.onPressedCheckBox,
    required this.isSelectCheck,
  }) : super(key: key);

  @override
  State<CheckBoxButtonWidget> createState() => _CheckBoxButtonWidgetState();
}

class _CheckBoxButtonWidgetState extends State<CheckBoxButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        //Kabul etme butonu
        IconButton(
            onPressed: widget.onPressedCheckBox,
            icon: widget.isSelectCheck
                ? const Icon(Icons.check_box)
                : const Icon(Icons.check_box_outline_blank)),
        Expanded(
          child: TextButton(
              child: const Text('KVKK okudum, anladım ve kabul ediyorum.'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const ShowPdf(),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
