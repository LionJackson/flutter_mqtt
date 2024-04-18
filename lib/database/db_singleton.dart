

import 'package:path/path.dart' as p;

import 'db_manager.dart';

class DBSingleton {
  static DBSingleton? _instance;
  late DBManager db;
  String? localId;
  factory DBSingleton() {
    if (_instance == null) {
      _instance = DBSingleton._();
      _instance!.db = DBManager();
    }
    return _instance!;
  }
  DBSingleton._();

}