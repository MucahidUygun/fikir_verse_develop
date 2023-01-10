import 'package:flutter/material.dart';
import 'package:fikir_verse/core/extension/context_extension.dart';

class ButtonWigdet extends StatelessWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color? color;
  final IconData? icons;
  const ButtonWigdet(
      {Key? key,
      required this.onPressed,
      required this.title,
      this.color,
      this.icons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return icons == null
        ? TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(color),
            ),
            onPressed: onPressed,
            child: Text(title),
          )
        : TextButton.icon(
            onPressed: onPressed,
            icon: Icon(icons!),
            label: Text(title),
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(context.primaryMediumValue),
              backgroundColor: MaterialStateProperty.all<Color>(color!),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          );
  }
}
