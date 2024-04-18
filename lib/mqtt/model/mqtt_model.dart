import 'package:json_annotation/json_annotation.dart';

part 'mqtt_model.g.dart';

///连接状态
@JsonSerializable()
class MqttConnectionModel {
  final String server; //连接地址
  final int port; //端口
  final String userId; //用户id
  final String? nickName; //用户昵称
  final int? keepAlivePeriod; //心跳间隔时间

  MqttConnectionModel(
      {required this.server, required this.port, required this.userId, this.nickName, this.keepAlivePeriod = 20});

  factory MqttConnectionModel.fromJson(Map<String, dynamic> json) => _$MqttConnectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$MqttConnectionModelToJson(this);
}

///数据
@JsonSerializable()
class MqttDataModel {
  final int timeMill; //发送消息 时间戳
  final String topic; //订阅类型
  final String userId; //发送者id
  final String? nickName; //发送者昵称
  final String? acceptId; //接收者id
  final String? data; //数据体

  MqttDataModel({required this.timeMill, required this.topic, required this.userId, this.nickName, this.acceptId, this.data});

  factory MqttDataModel.fromJson(Map<String, dynamic> json) => _$MqttDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MqttDataModelToJson(this);
}
