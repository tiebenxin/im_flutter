class TokenBean {
  String auditVersion;
  String neteaseAccid;
  int uid;
  String bankReqSignKey;
  bool deactivating;
  String accessToken;
  String neteaseToken;

  TokenBean(
      {this.auditVersion,
      this.neteaseAccid,
      this.uid,
      this.bankReqSignKey,
      this.deactivating,
      this.accessToken,
      this.neteaseToken});

  factory TokenBean.fromJson(Map<String, dynamic> data) {
    return TokenBean(
        auditVersion: data["auditVersion"],
        neteaseAccid: data["neteaseAccid"],
        uid: data["uid"],
        bankReqSignKey: data["bankReqSignKey"],
        deactivating: data["deactivating"],
        accessToken: data["accessToken"],
        neteaseToken: data["neteaseToken"]);
  }
}
