import 'package:fikir_verse/core/init/session_control.dart';
import 'package:fikir_verse/core/model/payment_requests_model.dart';
import 'package:fikir_verse/core/widget/add_payment_widget.dart';
import 'package:fikir_verse/core/widget/app_bar_widget.dart';
import 'package:fikir_verse/core/widget/chow_allert_dialog.dart';
import 'package:fikir_verse/core/widget/side_menu.dart';
import 'package:fikir_verse/core/widget/toast_message.dart';
import 'package:fikir_verse/page/paymentRequests/viewModel/payment_requests_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fikir_verse/core/extension/context_extension.dart';

class PaymentRequests extends StatefulWidget {
  const PaymentRequests({Key? key}) : super(key: key);

  @override
  State<PaymentRequests> createState() => _PaymentRequestsState();
}

class _PaymentRequestsState extends State<PaymentRequests> {
  final PaymentRequestsViewModel _model = PaymentRequestsViewModel();

  @override
  void initState() {
    fToast = FToast();
    fToast.init(context);
    _model.getPaymentRequests();
    _model.getUserModel();
    sessionControl(true, context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Observer(builder: (_) {
        return Visibility(
          visible: _model.hasCancelRequests,
          child: FloatingActionButton.extended(
            icon: const Icon(Icons.add),
            label: const Text('Ödeme Talebi Oluştur'),
            onPressed: () async {
              await checkNetworkControl(context);
              await _model.checkPaymentControl();
              if (_model.checkControl!.status) {
                addPaymentDialog(context, cancelOnPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                  _model.pointController.clear();
                }, confirmOnPressed: () async {
                  await _model.addPaymentFunction();
                  if (_model.addPayment!.status) {
                    _model.refreshPaymentRequests();
                  } else {
                    showToast(_model.addPayment!.message!.message,
                        const Color(0xfff1556c), 3, Icons.close, context);
                  }
                  _model.pointController.clear();
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                }, pointController: _model.pointController);
              } else {
                showToast(_model.checkControl!.message!.message,
                    const Color(0xfff1556c), 3, Icons.close, context);
              }
            },
          ),
        );
      }),
      drawer: const SideMenu(),
      appBar: PreferredSize(
        preferredSize: Size(context.width, context.heightNormalAppBar),
        child: Observer(builder: (_) {
          return BuildAppBar(
            title: 'Ödeme Taleplerim',
            isShowPoint: true,
            userPoint: _model.userModel?.point,
          );
        }),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _model.getUserModel();
          await checkNetworkControl(context);
          _model.refreshPaymentRequests();
        },
        child: Observer(
          builder: (_) {
            return ListView(
              padding: const EdgeInsets.all(6),
              children: [
                _model.model == null
                    ? const Center(child: CircularProgressIndicator())
                    : _model.model!.paymentActions!.isNotEmpty
                        ? Card(
                            elevation: 25,
                            shadowColor: Colors.grey.shade400,
                            child: DataTable(
                              columnSpacing: 10,
                                dataRowHeight: 75,
                                dividerThickness: 5,
                                showBottomBorder: false,
                                columns: const [
                                  DataColumn(
                                    label: Flexible(
                                      child: Center(
                                        child: Text(
                                          'PUAN',
                                        ),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Flexible(
                                      child: Text(
                                        'DURUM',
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Flexible(
                                      child: Text(
                                        'SEÇENEKLER',
                                      ),
                                    ),
                                  ),
                                ],
                                rows: _model.model!.paymentActions!
                                    .map(
                                      (e) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(
                                            Center(
                                              child: Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.04,
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xff47b2e4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Image.asset(
                                                        'assets/image/coin.png',
                                                      ),
                                                    ),
                                                    Text(
                                                      e.actionPoint,
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataCell(Text(
                                            e.statusName,
                                            style:
                                                const TextStyle(fontSize: 16),
                                          )),
                                          DataCell(e.actionStatus == '0'
                                              ? ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(const Color(
                                                                  0xfff1556c))),
                                                  child: const Text(
                                                    'İptal Et',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  onPressed: () async {
                                                    await checkNetworkControl(
                                                        context);
                                                    _model
                                                        .isHasCancelRequests();
                                                    buildShowAlertDialog(
                                                        context, e);
                                                    _model
                                                        .isHasCancelRequests();
                                                  },
                                                )
                                              : e.actionStatus == '2' ||
                                                      e.actionStatus == '3'
                                                  ? const Center(
                                                      child: Text(
                                                      'İptal Edildi',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ))
                                                  : const Center(
                                                      child: Text(
                                                      '-',
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    )))
                                        ],
                                      ),
                                    )
                                    .toList()),
                          )
                        : Center(
                            child: Container(
                                margin: const EdgeInsets.only(top: 200),
                                child: const Text(
                                  'Geçmiş bir ödeme talebiniz bulunamadı!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 20),
                                )),
                          ),
                const SizedBox(
                  height: 50,
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget buildShowAlertDialog(BuildContext context, PaymentAction e) {
    return showAlertDialog(context,
        confirmButtonTitle: 'İptal Et',
        title: 'Uyarı',
        desc: 'Ödeme talebinizi iptal etmek istediğinize emin misiniz?',
        cancelOnPressed: () {
      Navigator.of(context, rootNavigator: true).pop('dialog');
    }, confirmOnPressed: () async {
      await _model.cancelPaymentRequestsFunction(e.actionId);
      Navigator.of(context, rootNavigator: true).pop('dialog');
      if (_model.cancelModel?.status == true) {
        _model.refreshPaymentRequests();
      } else {
        showToast(_model.cancelModel!.error!.message!, const Color(0xfff1556c),
            3, Icons.close, context);
      }
    });
  }
}
