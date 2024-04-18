import 'package:flutter/cupertino.dart';

///连接状态
enum MqttState { connected, disconnected, connecting }

/// 订阅类型
enum MqttTopicType { chat,addUser }

///页面刷新监听
class MqttStateNotifier with ChangeNotifier {
  MqttState _connectionState = MqttState.disconnected;

  void setConnectionState(MqttState state) {
    _connectionState = state;
    notifyListeners();
  }

  MqttState get getConnectionState => _connectionState;
}
