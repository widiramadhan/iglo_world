class InviteFriends {
  String userNameReferred;
  String userNameReferral;
  String fullName;
  String filePath;
  String createDateString;
  String createDateTimeString;


  InviteFriends(this.userNameReferred, this.userNameReferral, this.fullName, this.filePath, this.createDateString, this.createDateTimeString);

  InviteFriends.fromJson(Map<String, dynamic> json) {
    userNameReferred = json['userNameReferred'].toString();
    userNameReferral = json['userNameReferral'];
    fullName = json['fullName'];
    filePath = json['filePath'];
    createDateString = json['createDateString'];
    createDateTimeString = json['createDateTimeString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userNameReferred'] = this.userNameReferred;
    data['userNameReferral'] = this.userNameReferral;
    data['fullName'] = this.fullName;
    data['filePath'] = this.filePath;
    data['createDateString'] = this.createDateString;
    data['createDateTimeString'] = this.createDateTimeString;
    return data;
  }
}
