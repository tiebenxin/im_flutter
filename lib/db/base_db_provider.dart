import 'package:cxdemo/db/db_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDBProvider {
  bool isTableExits = false;

  tableSqlString();

  tableName();

  tableBaseString(String name, String columnId) {
    return '''
    create table $name ($columnId integer primary key autoincrement,
    ''';
  }

  Future<Database> getDataBase() async {
    return await open();
  }

  @mustCallSuper
  prepare(name, String createSql) async {
    isTableExits = await DBManager.isTableExits(name);
    if (!isTableExits) {
      Database db = await DBManager.getDB();
      return await db.execute(createSql);
    }
  }
  @mustCallSuper
  open() async {
    if (!isTableExits) {
      await prepare(tableName(), tableSqlString());
    }
    return await DBManager.getDB();
  }
}
