import 'package:flutter/cupertino.dart';
import 'package:flutter_mqtt/view/entity/user_info.dart';

class UserNotifier with ChangeNotifier {
  UserInfo? userInfo;

  void setUserInfo(UserInfo? userInfo) {
    this.userInfo = userInfo;
    notifyListeners();
  }

  UserInfo? get getUserInfo => userInfo;
}
