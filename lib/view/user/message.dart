import 'package:flutter/material.dart';
import 'package:flutter_mqtt/database/db_manager.dart';
import 'package:provider/provider.dart';

import '../../database/tables/message.dart';
import '../../mqtt/mqtt_manager.dart';
import '../../mqtt/state/mqtt_state.dart';
import '../utils/util.dart';
import 'chat.dart';

///消息列表
class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    MqttStateNotifier counterNotifier = Provider.of<MqttStateNotifier>(context);
    MqttManager().setMqttStateNotifier(counterNotifier);
    return Scaffold(
      appBar: AppBar(title: Text('连接状态：${counterNotifier.getConnectionState.name}')),
      body: StreamBuilder<List<MessageEntity>>(
        stream: Message.watchMessage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<MessageEntity>? list = snapshot.data;
            if (list == null || list.isEmpty) {
              return const SizedBox.shrink();
            }
            return ListView.separated(
              itemCount: list.length,
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 1,
                  color: Colors.grey,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                MessageEntity item = list[index];
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
                                    userId: item.userId,
                                    nickName: item.nickName,
                                  )),
                        );
                      },
                    ));
              },
            );
          }
        },
      ),
    );
  }
}
