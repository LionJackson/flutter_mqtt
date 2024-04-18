import 'package:flutter/material.dart';
import 'package:flutter_mqtt/view/event/user_event.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

///用户
class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
      ),
      body: Consumer<UserNotifier>(builder: (context, value, child) {
        if (value.userInfo == null) {
          return const SizedBox.shrink();
        }
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value.userInfo!.nickName ?? '未知',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              value.userInfo!.userId ?? '未知',
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ));
      }),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton.icon(
            onPressed: () async {
              final SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('phone');
              prefs.remove('nickName');
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              }
            },
            icon: const Icon(Icons.exit_to_app),
            label: const Text('退出')),
      ),
    );
  }
}
