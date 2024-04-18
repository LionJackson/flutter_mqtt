import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_mqtt/database/tables/contacts.dart';
import 'package:flutter_mqtt/database/tables/message.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';
part 'db_manager.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'test.db'));
    return NativeDatabase(file);
  });
}

///数据库管理  构建flutter pub run build_runner build
@DriftDatabase(tables: [Contacts,Message,MessageRow])
class DBManager extends _$DBManager {
  DBManager() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}