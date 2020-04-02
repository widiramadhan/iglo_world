class User {
  String userName;
  List listMenu;
  String token;
  String roleId;
  String userType;

  User.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    listMenu = json['UserName'];
    token = json['bearerToken'];
    roleId = json['roleId'].toString();
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['listMenu'] = this.listMenu;
    data['bearerToken'] = this.token;
    data['roleId'] = this.roleId;
    data['user_type'] = this.userType;
    return data;
  }
}
