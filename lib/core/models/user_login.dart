class UserLogin {
  String userName;
  String phoneNumber;
  String email;
  String fullName;
  String roleId;
  String userType;
  String address;
  String company;
  String imageSource;
  String referralCode;

  UserLogin.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    fullName = json['fullName'];
    roleId = json['roleId'].toString();
    userType = json['userType'];
    address = json['fullName'];
    company = json['fullName'];
    imageSource = json['filePath'];
    referralCode = json['referralCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['fullName'] = this.fullName;
    data['roleId'] = this.roleId;
    data['userType'] = this.userType;
    data['fullName'] = this.address;
    data['fullName'] = this.company;
    data['filePath'] = this.imageSource;
    data['referralCode'] = this.referralCode;
    return data;
  }
}
