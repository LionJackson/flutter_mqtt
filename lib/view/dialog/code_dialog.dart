import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mqtt/view/entity/user_info.dart';
import 'package:qr_flutter/qr_flutter.dart';

///生成二维码
class QYCodeDialog extends StatefulWidget {
  final UserInfo? userInfo;

  const QYCodeDialog({super.key, this.userInfo});

  static Future show(BuildContext context, UserInfo userInfo) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (BuildContext ctx) {
        return QYCodeDialog(userInfo: userInfo);
      },
    );
  }

  @override
  State<QYCodeDialog> createState() => _QYCodeDialogState();
}

class _QYCodeDialogState extends State<QYCodeDialog> {
  ValueNotifier<bool> qyCodeNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Text(
            '扫码加好友',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          ValueListenableBuilder(
              valueListenable: qyCodeNotifier,
              builder: (context, value, child) {
                if (widget.userInfo == null) {
                  return const SizedBox.shrink();
                }
                String? nickName = widget.userInfo!.nickName;
                String? userId = widget.userInfo!.userId;
                String base64String = base64Encode(utf8.encode(nickName!));
                Map<String, dynamic> map = {};
                map['nickName'] = base64String;
                map['userId'] = userId!;
                String title = jsonEncode(map);
                return QrImageView(
                  data: title,
                  version: QrVersions.auto,
                  size: 150,
                  gapless: false,
                );
              }),
        ],
      ),
    ));
  }
}
