import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_mqtt/view/dialog/code_dialog.dart';
import 'package:flutter_mqtt/view/entity/user_info.dart';
import 'package:flutter_mqtt/view/user/chat.dart';
import 'package:flutter_mqtt/view/user/scanner.dart';
import 'package:provider/provider.dart';

import '../../database/db_manager.dart';
import '../../database/tables/contacts.dart';
import '../../mqtt/model/mqtt_model.dart';
import '../../mqtt/mqtt_manager.dart';
import '../../mqtt/state/mqtt_state.dart';
import '../event/user_event.dart';
import '../utils/util.dart';

///通讯录
class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  UserInfo? userInfo;
  List<ContactsEntity>? list;
  StreamSubscription<MqttDataModel>? _subscription;

  @override
  void initState() {
    super.initState();
    final filteredStream = MqttManager().chatStream.where((dataModel) {
      if (dataModel.topic == MqttTopicType.addUser.name) {
        return true;
      }
      return false;
    });
    _subscription = filteredStream.listen((dataModel) async {
      Map<String, dynamic> map = jsonDecode(dataModel.data!);
      print('二维码信息 map=$map');
      if (map['userId'] == userInfo!.userId) {
        Map<String, dynamic> map = {};
        map['userId'] = dataModel.userId;
        map['nickName'] = dataModel.nickName;
        await Contacts.update(map);
        loadData();
      }
    });
    loadData();
  }

  loadData() async {
    list = await Contacts.getAllData();
    setState(() {});
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userInfo = Provider.of<UserNotifier>(context).userInfo;
    return Scaffold(
        appBar: AppBar(
          title: const Text('通讯录'),
          actions: [
            IconButton(
                onPressed: () async {
                  final rs = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ScannerPage()),
                  );
                  if (rs is String) {
                    try {
                      Map<String, dynamic> map = Map.from(jsonDecode(rs.toString()));
                      addAlertDialog(map);
                    } catch (e) {
                      print('数据异常 e=$e');
                    }
                  }
                },
                icon: const Icon(Icons.add)),
            IconButton(
                onPressed: () {
                  QYCodeDialog.show(context, userInfo!);
                },
                icon: const Icon(Icons.qr_code_scanner_rounded))
          ],
        ),
        body: list == null || list!.isEmpty
            ? Container()
            : ListView.separated(
                itemCount: list!.length,
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider(
                    height: 1,
                    color: Colors.grey,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  ContactsEntity item = list![index];
                  return ColoredBox(
                      color: Util.randomColor().withAlpha(100),
                      child: ListTile(
                        leading: Container(
                          width: 30,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.blue),
                          child: Text(
                            item.nickName ?? '未知',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(Util.hidePhoneNumber(item.userId!)),
                        onTap: () async {
                          final rs = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPage(
                                      userId: item.userId,nickName: item.nickName,
                                    )),
                          );
                        },
                      ));
                },
              ));
  }


  void addAlertDialog(Map<String, dynamic> map) {
    String decodedString = utf8.decode(base64.decode(map['nickName']));
    map['nickName'] = decodedString;
    if (map.containsKey('nickName') && map['userId'] != userInfo!.userId) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('添加好友'),
            content: Text('好友昵称：$decodedString'),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                  MqttDataModel dataModel = MqttDataModel(
                      topic: MqttTopicType.addUser.name,
                      data: jsonEncode(map),
                      timeMill: DateTime.now().millisecondsSinceEpoch,
                      userId: userInfo!.userId!,
                      nickName: userInfo!.nickName);
                  MqttManager().publishMessage(dataModel);
                  await Contacts.update(map);
                  loadData();
                },
                child: const Text('添加'),
              ),
            ],
          );
        },
      );
    }
  }
}
