import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../db_manager.dart';
import '../db_singleton.dart';

///消息记录主表
@DataClassName('MessageEntity')
class Message extends Table {
  @override
  String get tableName => 'message';

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();

  TextColumn get userId => text().nullable()(); //用户id

  TextColumn get nickName => text().nullable()(); //用户昵称

  DateTimeColumn get createTime => dateTime().withDefault(currentDateAndTime)();

  static MessageCompanion companion(value) {
    return MessageCompanion(
      userId: Value(value['userId']),
      nickName: Value(value['nickName']),
    );
  }

  static Future<MessageEntity?> update(Map<String, dynamic> params) async {
    final db = DBSingleton().db;
    MessageEntity? entity;
    if (params['userId'] != null) {
      final rs = await (db.message.update()..where((tbl) => tbl.userId.equals(params['userId'])))
          .writeReturning(companion(params));
      entity = rs.isNotEmpty ? rs.first : null;
    }
    entity ??= await db.message.insertReturningOrNull(companion(params));
    return entity;
  }

  static Stream<List<MessageEntity>> watchMessage() {
    final db = DBSingleton().db;
    final query = db.message.select();
    return query.watch();
  }
}

@DataClassName('MessageRowEntity')
class MessageRow extends Table {
  @override
  String get tableName => 'message_row';

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();

  TextColumn get chatId => text().nullable()(); //聊天id

  TextColumn get userId => text().nullable()(); //用户id

  TextColumn get nickName => text().nullable()(); //用户昵称

  TextColumn get data => text().nullable()(); //聊天内容
  TextColumn get topic => text().nullable()(); //订阅类型

  TextColumn get messageId => text().references(Message, #id)();

  DateTimeColumn get createTime => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get timeMill => dateTime().nullable()();

  static MessageRowCompanion companion(value, String messageId) {
    return MessageRowCompanion(
        userId: Value(value['userId']),
        nickName: Value(value['nickName']),
        messageId: Value(messageId),
        data: Value(value['data']),
        chatId: Value(value['chatId']),
        topic: Value(value['topic']),
        timeMill: Value(DateTime.fromMillisecondsSinceEpoch(value['timeMill'])));
  }

  static update(Map<String, dynamic> params) async {
    final db = DBSingleton().db;
    MessageEntity? bean = await Message.update(params);
    if (bean == null) {
      return;
    }
    MessageRowEntity? entity;
    if (params['userId'] != null) {
      final rs = await (db.messageRow.update()..where((tbl) => tbl.userId.equals(params['userId'])))
          .writeReturning(companion(params, bean.id));
      entity = rs.isNotEmpty ? rs.first : null;
    }
    entity ??= await db.messageRow.insertReturningOrNull(companion(params, bean.id));
  }

  static Future<List<MessageRowEntity>?> getAllById(String chatId) async {
    final db = DBSingleton().db;
    final query = db.messageRow.select()
      ..where((tbl) => tbl.chatId.equals(chatId))
      ..orderBy([
        (message) => OrderingTerm(expression: message.timeMill,mode: OrderingMode.desc),
      ]);
    return await query.get();
  }
}
