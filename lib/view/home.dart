import 'package:flutter/material.dart';
import 'package:flutter_mqtt/mqtt/model/mqtt_model.dart';
import 'package:flutter_mqtt/mqtt/mqtt_manager.dart';
import 'package:flutter_mqtt/view/user/contact.dart';
import 'package:flutter_mqtt/view/user/message.dart';
import 'package:flutter_mqtt/view/user/user.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/salomon_bottom_bar.dart';
import 'entity/user_info.dart';
import 'event/user_event.dart';

///首页
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;
  late List<Widget> pages = [const MessagePage(), const ContactPage(), const UserPage()];
  ValueNotifier<int> currentIndexNotifier = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    initUserInfo();
  }

  @override
  void dispose() {
    currentIndexNotifier.dispose();
    super.dispose();
  }

  initUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    UserInfo userInfo = UserInfo(userId: prefs.getString('phone'), nickName: prefs.getString('nickName'));
    if (mounted) {
      Provider.of<UserNotifier>(context, listen: false).setUserInfo(userInfo);
    }
    print('昵称 nick=${userInfo.nickName}');
    MqttConnectionModel connectionModel = MqttConnectionModel(
        server: 'test.mosquitto.org', port: 1883, userId: userInfo.userId!, nickName: userInfo.nickName);
    MqttManager().initClient(connectionModel, isConnect: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder<int>(
          valueListenable: currentIndexNotifier,
          builder: (context, val, child) {
            return IndexedStack(index: val, children: pages);
          },
        ),
        bottomNavigationBar: Container(
            height: 65,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(15)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )
                ]),
            child: SalomonBottomBar(
              currentIndex: currentPage,
              onTap: (i) => setState(() {
                currentPage = i;
                onTapBottomTab(i);
              }),
              items: [
                SalomonBottomBarItem(
                  icon: const Icon(Icons.message_rounded),
                  title: const Text("消息"),
                  selectedColor: const Color(0xff369caa),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.perm_contact_calendar_rounded),
                  title: const Text("通讯录"),
                  selectedColor: const Color(0xff369caa),
                ),
                SalomonBottomBarItem(
                  icon: const Icon(Icons.person),
                  title: const Text('我的'),
                  selectedColor: const Color(0xff369caa),
                ),
              ],
            )));
  }

  Future<void> onTapBottomTab(int i, {BuildContext? context}) async {
    currentIndexNotifier.value = i;
  }
}
