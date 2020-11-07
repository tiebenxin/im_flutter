import 'package:cxdemo/db/bean/msg_content.dart';

class TextMessage implements IMsgContent {
  String msgId;
  String content;

  @override
  String tableName = "text_message";

  @override
  fromMap(Map<String, dynamic> map) {
    msgId = map["msgId"];
    content = map["content"];
  }

  @override
  toMap() {
    Map<String, dynamic> map = {
      "msgId": msgId,
      "content": content,
    };
    return map;
  }


  @override
  createSqlString() {

  }
}
