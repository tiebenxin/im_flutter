import 'package:cxdemo/db/bean/msg_content.dart';

final String _msgId = "msgId";
final String _timestamp = "timestamp";
final String _sendStatus = "sendStatus";
final String _isRead = "isRead";
final String _requestId = "requestId";
final String _fromUid = "fromUid";
final String _fromNickName = "fromNickName";
final String _fromAvatar = "fromAvatar";
final String _fromGroupNickName = "fromGroupNickName";
final String _toUid = "toUid";
final String _gid = "gid";
final String _msgType = "msgType";

class MessageBean implements IMsgContent {
  String msgId;
  int timestamp;
  int sendStatus;
  bool isRead; //自己本地是否已读
  String requestId;
  int fromUid;
  String fromNickName;
  String fromAvatar;
  String fromGroupNickName;
  int toUid;
  String gid;
  int msgType;

  MessageBean(
      this.msgId,
      this.timestamp,
      this.sendStatus,
      this.isRead,
      this.requestId,
      this.fromUid,
      this.fromNickName,
      this.fromAvatar,
      this.fromGroupNickName,
      this.toUid,
      this.gid,
      this.msgType);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      _msgId: msgId,
      _timestamp: timestamp,
      _sendStatus: sendStatus,
      _isRead: isRead,
      _requestId: requestId,
      _fromUid: fromUid,
      _fromNickName: fromNickName,
      _fromAvatar: fromAvatar,
      _fromGroupNickName: fromGroupNickName,
      _toUid: toUid,
      _gid: gid,
      _msgType: msgType,
    };
    return map;
  }

  @override
  fromMap(Map<String, dynamic> map) {
    msgId = map[_msgId];
    timestamp = map[_timestamp];
    sendStatus = map[_sendStatus];
    isRead = map[_isRead];
    requestId = map[_requestId];
    fromUid = map[_fromUid];
    fromNickName = map[_fromNickName];
    fromAvatar = map[_fromAvatar];
    fromGroupNickName = map[_fromGroupNickName];
    toUid = map[_toUid];
    gid = map[_gid];
    msgType = map[_msgType];
  }

  @override
  String tableName = "t_message";

  @override
  createSqlString() {

  }

}
