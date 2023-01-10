import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BuildAppBar extends StatelessWidget {
  final int? userPoint;
  final PreferredSizeWidget? bottom;
  final String title;
  final Widget? leading;
  final bool isShowPoint;
  const BuildAppBar({
    Key? key,
    required this.isShowPoint,
    this.bottom,
    this.userPoint,
    required this.title,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      systemOverlayStyle:
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
      leading: leading,
      title: Text(title,style: const TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
      bottom: bottom,
      actions: isShowPoint && userPoint != null
          ? [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff47b2e4),
                      borderRadius: BorderRadius.circular(50)),
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image/coin.ico',
                      ),
                      Text(
                        '$userPoint',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ]
          : null,
      backgroundColor: const Color(0xff37517e),
    );
  }
}
