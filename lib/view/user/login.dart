import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mqtt/view/entity/user_info.dart';
import 'package:flutter_mqtt/view/event/user_event.dart';
import 'package:flutter_mqtt/view/home.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final mobileFocus = FocusNode();
  final inputBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.withAlpha(100)),
  );

  @override
  void dispose() {
    mobileController.dispose();
    mobileFocus.dispose();
    super.dispose();
  }

  passwordLogin() async {
    if (nameController.text.isEmpty) {
      Fluttertoast.showToast(msg: '请输入昵称');
      return;
    }
    if (mobileController.text.isEmpty) {
      Fluttertoast.showToast(msg: '请输入手机号');
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nickName', nameController.text);
    prefs.setString('phone', mobileController.text);
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: contentWidget(),
      ),
    );
  }

  Widget contentWidget() {
    return Stack(
      children: [
        Container(
          height: 160,
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 20),
          decoration: const BoxDecoration(color: Colors.blue),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '请登录',
                style: TextStyle(fontSize: 28, color: Colors.white),
              ),
              Text(
                'MQTT通信',
                style: TextStyle(fontSize: 20, color: Colors.white),
              )
            ],
          ),
        ),
        Positioned(
          top: 140,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                    controller: nameController,
                    keyboardAppearance: Theme.of(context).brightness,
                    textInputAction: TextInputAction.next,
                    selectionHeightStyle: BoxHeightStyle.max,
                    selectionWidthStyle: BoxWidthStyle.max,
                    decoration: InputDecoration(
                      labelText: '昵称',
                      prefixIcon: const Icon(Icons.person),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      suffixIcon: nameController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                nameController.clear();
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.cancel,
                                size: 18,
                                color: Theme.of(context).disabledColor,
                              ),
                            )
                          : const SizedBox.shrink(),
                    )),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    keyboardAppearance: Theme.of(context).brightness,
                    inputFormatters: [LengthLimitingTextInputFormatter(11)],
                    textInputAction: TextInputAction.next,
                    selectionHeightStyle: BoxHeightStyle.max,
                    selectionWidthStyle: BoxWidthStyle.max,
                    decoration: InputDecoration(
                      labelText: '手机号',
                      prefixIcon: const Icon(Icons.phone_android_outlined),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      suffixIcon: mobileController.text.isNotEmpty && mobileFocus.hasPrimaryFocus
                          ? IconButton(
                              onPressed: () {
                                mobileController.clear();
                                setState(() {});
                              },
                              icon: Icon(
                                Icons.cancel,
                                size: 18,
                                color: Theme.of(context).disabledColor,
                              ),
                            )
                          : const SizedBox.shrink(),
                    )),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15), // 设置圆角半径
                        )),
                    onPressed: passwordLogin,
                    child: const Text(
                      '登录',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
