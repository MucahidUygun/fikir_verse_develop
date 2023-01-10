import 'package:fikir_verse/core/init/session_control.dart';
import 'package:fikir_verse/core/widget/app_bar_widget.dart';
import 'package:fikir_verse/core/widget/side_menu.dart';
import 'package:fikir_verse/page/pointAction/viewModel/point_action_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fikir_verse/core/extension/context_extension.dart';

class PointAction extends StatefulWidget {
  const PointAction({Key? key}) : super(key: key);

  @override
  State<PointAction> createState() => _PointActionState();
}

class _PointActionState extends State<PointAction> {
  final PointActionViewModel _viewModel = PointActionViewModel();

  @override
  void initState() {
    _viewModel.getServicesData();
    sessionControl(true, context);
    _viewModel.getUserModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: PreferredSize(
        preferredSize: Size(context.width, context.heightNormalAppBar),
        child: Observer(builder: (_) {
          return BuildAppBar(
            title: 'Puan Hareketlerim',
            isShowPoint: true,
            userPoint: _viewModel.userModel?.point,
          );
        }),
      ),
      body: Observer(
        builder: (_) {
          return ListView(
            padding: const EdgeInsets.all(6),
            children: [
              _viewModel.model == null
                  ? const Center(child: CircularProgressIndicator())
                  : Card(
                      elevation: 25,
                      shadowColor: Colors.grey.shade400,
                      child: DataTable(
                        dataRowHeight: 75,
                        dividerThickness: 5,
                        showBottomBorder: false,
                        columns: const [
                          DataColumn(
                              label: Flexible(
                                  child: Center(
                            child: Text(
                              'İŞLEM TÜRÜ',
                            ),
                          ))),
                          DataColumn(
                              label: Flexible(
                                  child: Text(
                            'PUAN TUTARI',
                          ))),
                        ],
                        rows: _viewModel.model!.pointActions
                            .map(
                              (e) => DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Text(
                                      e.actionType,
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  DataCell(
                                    e.plusMinus == '-'
                                        // - Durum için
                                        ? Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                            decoration: BoxDecoration(
                                                color: const Color(0xffdc3545),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.asset(
                                                    'assets/image/coin.png',
                                                  ),
                                                ),
                                                Text(
                                                  '${e.plusMinus} ${e.point}',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          )
                                        // + Durum için
                                        : Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                            decoration: BoxDecoration(
                                                color: const Color(0xff47b2e4),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.3,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Image.asset(
                                                    'assets/image/coin.png',
                                                  ),
                                                ),
                                                Text(
                                                  '${e.plusMinus} ${e.point}',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    )
            ],
          );
        },
      ),
    );
  }
}
