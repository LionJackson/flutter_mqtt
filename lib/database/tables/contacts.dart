

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../db_manager.dart';
import '../db_singleton.dart';

///通讯录
@DataClassName('ContactsEntity')
class Contacts extends Table {
  @override
  String get tableName => 'contacts';

  TextColumn get id => text().clientDefault(() => const Uuid().v4())();

  TextColumn get userId => text().nullable()(); //用户id

  TextColumn get nickName => text().nullable()(); //用户昵称

  DateTimeColumn get createTime => dateTime().withDefault(currentDateAndTime)();

  static ContactsCompanion companion(value) {
    return ContactsCompanion(
      userId: Value(value['userId']),
      nickName: Value(value['nickName']),
    );
  }

  static update(Map<String, dynamic> params) async {
    final db = DBSingleton().db;
    ContactsEntity? entity;
    if (params['userId'] != null) {
      final rs = await (db.contacts.update()..where((tbl) => tbl.userId.equals(params['userId'])))
          .writeReturning(companion(params));
      entity = rs.isNotEmpty ? rs.first : null;
    }
    entity ??= await db.contacts.insertReturningOrNull(companion(params));
  }

  static Future<List<ContactsEntity>> getAllData() async {
    final db = DBSingleton().db;
    final query = db.contacts.select();
    return await query.get();
  }
}
