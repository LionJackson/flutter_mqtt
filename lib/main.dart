import 'package:flutter/material.dart';
import 'package:flutter_mqtt/view/event/user_event.dart';
import 'package:flutter_mqtt/view/home.dart';
import 'package:flutter_mqtt/view/user/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'mqtt/state/mqtt_state.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => UserNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => MqttStateNotifier(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MQTT',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          color: Colors.blue.shade100,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white)
              // 可以根据需要修改其他样式，例如文本颜色、阴影等
              ),
        ),
      ),
      home: const ScreenPage(),
    );
  }
}

class ScreenPage extends StatefulWidget {
  const ScreenPage({super.key});

  @override
  State<ScreenPage> createState() => _ScreenPageState();
}

class _ScreenPageState extends State<ScreenPage> {
  @override
  void initState() {
    super.initState();
    initLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  initLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => prefs.containsKey('phone') ? const HomePage() : const LoginPage()),
      );
    }
  }
}
