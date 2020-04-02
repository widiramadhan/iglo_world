class TransactionStatus {
  String transactionStatusId;
  String transactionStatusName;


  TransactionStatus(this.transactionStatusId, this.transactionStatusName);

  TransactionStatus.fromJson(Map<String, dynamic> json) {
    transactionStatusId = json['id'].toString();
    transactionStatusName = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.transactionStatusId;
    data['name'] = this.transactionStatusName;
    return data;
  }
}
