import 'package:cxdemo/db/base_db_provider.dart';
import 'package:sqflite_common/sqlite_api.dart';

class ChatDao implements BaseDBProvider {
  final String name = "t_message"; //MessageBean
  final String columnId = "msgId"; //主键字段
  @override
  bool isTableExits;

  @override
  Future<Database> getDataBase() {
    // TODO: implement getDataBase
    throw UnimplementedError();
  }

  @override
  tableBaseString(String name, String createSq) {
    // TODO: implement tableBaseString
    throw UnimplementedError();
  }

  @override
  tableName() {
    // TODO: implement tableName
    throw UnimplementedError();
  }

  @override
  tableSqlString() {
    return tableBaseString(name, columnId) +
        '''
    msgId text not null,
    timestamp integer,
    sendStatus integer,
    isRead bool,
    requestId text not null,
    fromUid integer,
    fromNickName String,
    fromAvatar String,
    fromGroupNickName String,
    fromGroupNickName String,
    toUid integer,
    gid text not null,
    msgType  integer
    ''';
  }

  @override
  open() {}

  @override
  prepare(name, String createSql) {}
}
