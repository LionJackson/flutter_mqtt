import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mqtt/database/tables/message.dart';
import 'package:flutter_mqtt/view/entity/user_info.dart';
import 'package:flutter_mqtt/view/event/user_event.dart';
import 'package:provider/provider.dart';

import '../../database/db_manager.dart';
import '../../mqtt/model/mqtt_model.dart';
import '../../mqtt/mqtt_manager.dart';
import '../../mqtt/state/mqtt_state.dart';

///聊天
class ChatPage extends StatefulWidget {
  final String? userId;
  final String? nickName;

  const ChatPage({super.key, this.userId, this.nickName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  StreamSubscription<MqttDataModel>? _subscription;
  List<MqttDataModel> list = [];
  final TextEditingController _textEditingController = TextEditingController();
  UserInfo? userInfo;
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final filteredStream = MqttManager().chatStream.where((dataModel) {
      print('数据回调 dataModel=${dataModel.toJson()}');
      if (dataModel.acceptId == userInfo!.userId) {
        return true;
      }
      return false;
    });
    _subscription = filteredStream.listen((dataModel) {
      addData(dataModel);
    });
    WidgetsBinding.instance.addPostFrameCallback((call) async {
      List<MessageRowEntity>? listRow = await MessageRow.getAllById(widget.userId!);
      if (listRow == null) {
        return;
      }
      list.addAll(listRow.map((e) {
        return MqttDataModel.fromJson(e.toJson());
      }).toList());
      setState(() {});
    });
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
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.nickName ?? '聊天'),
      ),
      body: Column(
        children: [
          // 页面内容列表
          Expanded(
            child: list.isEmpty
                ? Container()
                : Align(
                    alignment: Alignment.topCenter,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: list.length,
                      reverse: true,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        MqttDataModel item = list[index];
                        bool isMe = item.userId == userInfo!.userId;
                        return Row(
                          mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                          children: [
                            if (!isMe) const SizedBox(width: 10),
                            if (!isMe)
                              Container(
                                width: 30,
                                height: 30,
                                margin: const EdgeInsets.only(top: 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.blue),
                                child: Text(
                                  item.nickName ?? '未知',
                                  style: const TextStyle(color: Colors.white, fontSize: 11),
                                ),
                              ),
                            Container(
                                decoration: BoxDecoration(
                                    color: Colors.green[100],
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(isMe ? 15 : 0),
                                        bottomRight: Radius.circular(isMe ? 0 : 15),
                                        topRight: Radius.circular(isMe ? 15 : 5),
                                        topLeft: Radius.circular(isMe ? 5 : 15))),
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                                child: Text(item.data!)),
                            if (isMe)
                              Container(
                                width: 30,
                                height: 30,
                                margin: const EdgeInsets.only(top: 20),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: Colors.blue),
                                child: Text(
                                  item.nickName ?? '未知',
                                  style: const TextStyle(color: Colors.white, fontSize: 11),
                                ),
                              ),
                            if (isMe) const SizedBox(width: 10)
                          ],
                        );
                      },
                    )),
          ),
          // 底部输入框
          inputFieldWidget()
        ],
      ),
    );
  }

  addData(MqttDataModel dataModel) {
    list.insert(0, dataModel);
    Map<String, dynamic> map = dataModel.toJson();
    map['chatId'] = widget.userId;
    MessageRow.update(map);
    setState(() {});
  }

  Widget inputFieldWidget() {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(10),
      color: Colors.grey[200],
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                  hintText: '输入消息',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0)),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
              width: 80,
              height: 40,
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                ),
                onPressed: () {
                  MqttDataModel dataModel = MqttDataModel(
                      userId: userInfo!.userId!,
                      topic: MqttTopicType.chat.name,
                      nickName: userInfo!.nickName,
                      acceptId: widget.userId,
                      data: _textEditingController.text,
                      timeMill: DateTime.now().millisecondsSinceEpoch);
                  MqttManager().publishMessage(dataModel);
                  _textEditingController.clear();
                  addData(dataModel);
                  scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Text('发送'),
              )),
        ],
      ),
    );
  }
}
