import 'dart:io';

import 'package:sqflite/sqflite.dart';

class DBManager {
  static const int VERSION = 1;
  static String DN_NAME = "cx.db";

  static Database database;

  initDB(int uid) async {
    var databasePath = await getDatabasesPath();
    String dbName = uid.toString() + "-" + DN_NAME;
    String path = databasePath + dbName;
    if (Platform.isIOS) {
      path = databasePath + "/" + dbName;
    }

    database = await openDatabase(path,
        version: VERSION,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        onDowngrade: onDatabaseDowngradeDelete);
  }

  void _onCreate(Database db, int version) async {
    var batch = db.batch();
//    db.execute(ArticleProvider().createSql);
    await batch.commit();
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    Batch batch = db.batch();
    if (oldVersion == 1) {
//      batch.execute('alter table ta_person add fire text');
    } else if (oldVersion == 2) {
//      batch.execute('alter table ta_person add water text');
    } else if (oldVersion == 3) {}
    oldVersion++;
    //升级后版本还低于当前版本，继续递归升级
    if (oldVersion < newVersion) {
      _onUpgrade(db, oldVersion, newVersion);
    }
    await batch.commit();
  }
}
