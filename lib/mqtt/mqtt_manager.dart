import 'dart:async';
import 'dart:convert';

import 'package:flutter_mqtt/mqtt/state/mqtt_state.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

import 'model/mqtt_model.dart';

///mqtt连接管理
class MqttManager {
  MqttServerClient? _client;
  MqttState mqttState = MqttState.disconnected;
  MqttConnectionModel? _connectionModel;
  MqttStateNotifier? _currentNotifier; //连接状态
  final _chatController = StreamController<MqttDataModel>.broadcast(); //监听消息

  static MqttManager? _instance;

  MqttManager._();

  factory MqttManager() {
    _instance ??= MqttManager._();
    return _instance!;
  }

  String? get clientIdentifier => _connectionModel!.userId;

  Stream<MqttDataModel> get chatStream => _chatController.stream;

  setMqttStateNotifier(MqttStateNotifier currentNotifier) {
    _currentNotifier = currentNotifier;
  }

  ///初始化连接
  void initClient(MqttConnectionModel connectionModel, {bool isConnect = false}) {
    _connectionModel = connectionModel;
    if (_client == null) {
      _client = MqttServerClient(connectionModel.server, clientIdentifier!);
      _client!.port = connectionModel.port;
      _client!.keepAlivePeriod = connectionModel.keepAlivePeriod!;
      _client!.onDisconnected = _onDisconnected;
      _client!.secure = false;
      _client!.logging(on: true);

      _client!.onConnected = _onConnected;
      _client!.onSubscribed = _onSubscribed;
      print('initClient model=$connectionModel');
      final MqttConnectMessage connMess = MqttConnectMessage()
          .withClientIdentifier(clientIdentifier!)
          .withWillTopic('withWillTopic')
          .withWillMessage('withWillMessage')
          .startClean()
          .withWillQos(MqttQos.atLeastOnce);
      _client!.connectionMessage = connMess;
      if (isConnect) {
        connect();
      }
    }
  }

  /// 开始连接
  /// topic:订阅消息
  /// qos:消息类型
  void connect({String? topic, MqttQos qos = MqttQos.atLeastOnce}) async {
    if (_client == null) {
      print('未初始化连接');
      return;
    }
    try {
      print('开始连接....');
      mqttState = MqttState.connecting;
      if (_currentNotifier != null) {
        _currentNotifier!.setConnectionState(mqttState);
      }
      await _client!.connect();
      subscribeMessage(subtopic: MqttTopicType.chat.name);
      subscribeMessage(subtopic: MqttTopicType.addUser.name);
    } on Exception catch (e) {
      print('连接异常 $e');
      disconnect();
    }
  }

  /// 断开连接
  void disconnect() {
    if (_client == null) {
      print('未初始化连接');
      return;
    }
    print('断开连接');
    _client!.disconnect();
  }

  ///发送消息
  void publishMessage(MqttDataModel mqttDataModel) async {
    if (_client == null) {
      print('未初始化连接');
      return;
    }
    if (mqttState != MqttState.connected) {
      print('未连接，请稍后');
      return;
    }
    final MqttClientPayloadBuilder builder = MqttClientPayloadBuilder();
    String data = jsonEncode(mqttDataModel.toJson());
    builder.addUTF8String(data);
    print('发送消息 data$data _connectionModel=${_connectionModel!.toJson()}');
    _client!.publishMessage(mqttDataModel.topic, MqttQos.atMostOnce, builder.payload!);
  }

  /// 订阅主题
  subscribeMessage({required String subtopic, MqttQos qos = MqttQos.atLeastOnce}) {
    if (_client == null) {
      print('未初始化连接');
      return;
    }
    if (mqttState != MqttState.connected) {
      print('未连接，请稍后');
      return;
    }
    _client!.subscribe(subtopic, qos);
  }

  /// 取消订阅
  void unsubscribeMessage({required String unSubtopic}) {
    if (_client == null) {
      print('未初始化连接');
      return;
    }
    _client!.unsubscribe(unSubtopic);
  }

  /// 订阅主题成功回调
  void _onSubscribed(String topic) {
    print('订阅主题成功');
  }

  /// 连接断开回调
  void _onDisconnected() {
    if (_client == null) {
      print('未初始化连接');
      return;
    }
    print('连接断开回调 code=${_client!.connectionStatus!.returnCode}');
    if (_client!.connectionStatus!.returnCode == MqttConnectReturnCode.noneSpecified) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
    mqttState = MqttState.disconnected;
    if (_currentNotifier != null) {
      _currentNotifier!.setConnectionState(mqttState);
    }
  }

  /// 连接成功回调
  void _onConnected() {
    if (_client == null) {
      print('未初始化连接');
      return;
    }
    mqttState = MqttState.connected;
    if (_currentNotifier != null) {
      _currentNotifier!.setConnectionState(mqttState);
    }
    print('连接成功回调');
    _client!.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final MqttReceivedMessage recMess = c![0];
      final MqttPublishMessage pubMess = recMess.payload as MqttPublishMessage;
      String topic = recMess.topic;
      String pts = const Utf8Decoder().convert(pubMess.payload.message);
      print('MQTT消息监听 topic=$topic pts=$pts');
      MqttDataModel model = MqttDataModel.fromJson(jsonDecode(pts));

      _chatController.add(model);
    });
  }
}
