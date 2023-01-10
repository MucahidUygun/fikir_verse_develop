import 'package:fikir_verse/core/init/session_control.dart';
import 'package:fikir_verse/core/model/bank_info_delete_model.dart';
import 'package:fikir_verse/core/model/post_bank_info.dart';
import 'package:fikir_verse/core/widget/app_bar_widget.dart';
import 'package:fikir_verse/core/widget/button_widget.dart';
import 'package:fikir_verse/core/widget/chow_allert_dialog.dart';
import 'package:fikir_verse/core/widget/input_widget.dart';
import 'package:fikir_verse/core/widget/side_menu.dart';
import 'package:fikir_verse/core/widget/toast_message.dart';
import 'package:fikir_verse/page/bankInfo/viewModel/bank_info_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:fikir_verse/core/extension/context_extension.dart';

class BankInfo extends StatefulWidget {
  const BankInfo({Key? key}) : super(key: key);

  @override
  State<BankInfo> createState() => _BankInfoState();
}

class _BankInfoState extends State<BankInfo> {
  BankInfoViewModel bankInfoViewModel = BankInfoViewModel();

  @override
  void initState() {
    bankInfoViewModel.getBankInfoFunction();
    fToast = FToast();
    fToast.init(context);
    bankInfoViewModel.getUserModel();
    sessionControl(true, context);
    super.initState();
  }

  var ibanFormatter = MaskTextInputFormatter(
    mask: 'TR00 0000 0000 0000 0000 0000 00',
    filter: {"0": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  var formatterTC = MaskTextInputFormatter(
    mask: 'XXXXXXXXXXX',
    filter: {"X": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: PreferredSize(
        preferredSize: Size(context.width, context.heightNormalAppBar),
        child: Observer(
          builder: (_) {
            return BuildAppBar(
              title: 'Banka Bilgileri',
              isShowPoint: true,
              userPoint: bankInfoViewModel.userModel?.point,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Tc
            Observer(builder: (_) {
              return InputWidget(
                haveToolTip: true,
                titleName: 'T.C Numarası',
                hintText: 'T.C Numarası',
                maxLength: 11,
                keyboard: TextInputType.number,
                inputType: [formatterTC],
                textEditingController: bankInfoViewModel.numberTC,
              );
            }),
            //Banka ismi
            Observer(builder: (_) {
              return InputWidget(
                  titleName: 'Banka Adı',
                  hintText: 'Banka Adı',
                  textEditingController: bankInfoViewModel.bankName);
            }),
            //Hesap sahibi adı soy adı
            Observer(builder: (_) {
              return InputWidget(
                  titleName: 'Hesap Sahibi Adı Soyadı',
                  hintText: 'Hesap Sahibi Adı Soyadı',
                  textEditingController: bankInfoViewModel.accountNameSurname);
            }),
            //Şube kodu
            Observer(builder: (_) {
              return InputWidget(
                  titleName: 'Şube Kodu',
                  hintText: 'Şube Kodu',
                  textEditingController: bankInfoViewModel.branchCode);
            }),
            //Hesap Numarası
            Observer(builder: (_) {
              return InputWidget(
                  titleName: 'Hesap Numarası',
                  hintText: 'Hesap Numarası',
                  textEditingController: bankInfoViewModel.accountNumber);
            }),
            //IBAN
            Observer(builder: (_) {
              return InputWidget(
                  inputType: [ibanFormatter],
                  titleName: 'IBAN',
                  hintText: 'IBAN',
                  keyboard: TextInputType.number,
                  textEditingController: bankInfoViewModel.ibanText);
            }),
            //İstek butonu
            Observer(builder: (_) {
              return Container(
                margin:const EdgeInsets.only(bottom: 20,top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    bankInfoViewModel.isShowDeleteButton
                        ? ButtonWigdet(
                            onPressed: () {
                              showAlertDialog(context,
                                  confirmButtonTitle: 'Sil',
                                  desc:
                                      'Banka bilgilerinizi silmek istediğinize emin misiniz?',
                                  title: 'Uyarı', cancelOnPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                              }, confirmOnPressed: () async {
                                BankInfoDeleteModel model =
                                    await bankInfoViewModel
                                        .deleteBankInfoFunction();
                                Navigator.of(context, rootNavigator: true)
                                    .pop('dialog');
                                if (model.status) {
                                  showToast(
                                      model.message.message,
                                      const Color.fromARGB(255, 43, 167, 48),
                                      3,
                                      Icons.check,
                                      context);
                                  bankInfoViewModel.clearTextController();
                                } else {
                                  showToast(
                                      model.message.message,
                                      Colors.redAccent,
                                      3,
                                      Icons.close,
                                      context);
                                }
                              });
                            },
                            title: 'Sil',
                            icons: Icons.delete,
                            color: const Color(0xffdc3545),
                          )
                        : const SizedBox(),
                    const SizedBox(
                      width: 15,
                    ),
                    ButtonWigdet(
                      onPressed: () async {
                        await checkNetworkControl(context);
                        PostBankInfoModel? model =
                            await bankInfoViewModel.postBankInfoFunction();
                        if (model == null) {
                          showToast('Lütfen boş alanları doldurun!',
                              Colors.redAccent, 3, Icons.close, context);
                        } else if (model.status == false) {
                          showToast(model.message.message, Colors.redAccent, 3,
                              Icons.close, context);
                        } else {
                          showToast(
                              model.message.message,
                              const Color.fromARGB(255, 43, 167, 48),
                              3,
                              Icons.check,
                              context);
                          bankInfoViewModel.checkDeleteButton(postStatus: true);
                        }
                      },
                      title: 'Kaydet',
                      icons: Icons.save,
                      color: const Color(0xff47b2e4),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
