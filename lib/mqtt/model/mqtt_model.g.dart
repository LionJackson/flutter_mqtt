// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mqtt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MqttConnectionModel _$MqttConnectionModelFromJson(Map<String, dynamic> json) =>
    MqttConnectionModel(
      server: json['server'] as String,
      port: json['port'] as int,
      userId: json['userId'] as String,
      nickName: json['nickName'] as String?,
      keepAlivePeriod: json['keepAlivePeriod'] as int? ?? 20,
    );

Map<String, dynamic> _$MqttConnectionModelToJson(
        MqttConnectionModel instance) =>
    <String, dynamic>{
      'server': instance.server,
      'port': instance.port,
      'userId': instance.userId,
      'nickName': instance.nickName,
      'keepAlivePeriod': instance.keepAlivePeriod,
    };

MqttDataModel _$MqttDataModelFromJson(Map<String, dynamic> json) =>
    MqttDataModel(
      timeMill: json['timeMill'] as int,
      topic: json['topic'] as String,
      userId: json['userId'] as String,
      nickName: json['nickName'] as String?,
      acceptId: json['acceptId'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$MqttDataModelToJson(MqttDataModel instance) =>
    <String, dynamic>{
      'timeMill': instance.timeMill,
      'topic': instance.topic,
      'userId': instance.userId,
      'nickName': instance.nickName,
      'acceptId': instance.acceptId,
      'data': instance.data,
    };
