import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatelessWidget {
  final String? titleName;
  final TextInputType? keyboard;
  final TextEditingController textEditingController;
  final int? maxLength;
  final List<TextInputFormatter>? inputType;
  final bool? obscureText;
  final Widget? visible;
  final String? hintText;
  final bool? haveToolTip;
  final String? Function(String?)? validator;
  const InputWidget(
      {Key? key,
      this.titleName,
      required this.textEditingController,
      this.keyboard,
      this.maxLength,
      this.inputType,
      this.obscureText,
      this.visible,
      this.hintText,
      this.validator,
      this.haveToolTip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleName != null
              ? Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(titleName ?? "",
                          softWrap: true,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontSize: 18,
                          )),
                    ),
                    haveToolTip == true
                        ? Tooltip(
                            triggerMode: TooltipTriggerMode.tap,
                            showDuration: const Duration(seconds: 30),
                            message:
                                'Bu bilgiler hesabınızda biriken puanlarınızı Türk Lirasına çevirip banka hesaplarınıza aktarabilmek için zorunlu olarak alınması gereken bilgilerdir. Ayrıca TC kimlik numaranız sizin tekil ve gerçek bir kişi olduğunuzu garanti etmektedir. Bu bilgiler gerçek kullanıcılarımıza daha fazla anket göndermemize olanak sağlar. Sitemize kayıt esnasında ya da sonrasında girmiş olduğunuz tüm kişisel bilgiler sistemimizde yüksek güvenlikli alanlarda saklanmakta ve korunmaktadır.',
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: const Color(0xff6c757d),
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Icon(
                                Icons.question_mark_rounded,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                          )
                        : const SizedBox()
                  ],
                )
              : const SizedBox(),
          TextFormField(
            //autofocus: true,
            validator: validator,
            obscureText: obscureText ?? false,
            keyboardType: keyboard,
            maxLength: maxLength,
            minLines: 1,
            controller: textEditingController,
            cursorWidth: 3.0,
            cursorColor: Colors.blue,
            inputFormatters: inputType,
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: visible,
              border: OutlineInputBorder(
                gapPadding: 16.0,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
