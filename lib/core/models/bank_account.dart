class BankAccount {
  String bankName;
  String accountNumber;
  String accountName;
  String userName;
  String bankId;


  BankAccount(this.bankName, this.accountNumber, this.accountName, this.userName,
      this.bankId);

  BankAccount.fromJson(Map<String, dynamic> json) {
    bankName = json['bankName'];
    accountNumber = json['accountNumber'];
    accountName = json['accountName'];
    userName = json['userName'];
    bankId = json['bankId'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankName'] = this.bankName;
    data['accountNumber'] = this.accountNumber;
    data['accountName'] = this.accountName;
    data['userName'] = this.userName;
    data['bankId'] = this.bankId;
    return data;
  }
}
