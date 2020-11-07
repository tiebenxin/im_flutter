abstract class IMsgContent {
  String tableName;

  toMap();

  fromMap(Map<String, dynamic> map);

  createSqlString();
}
