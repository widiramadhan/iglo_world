class JobRecomendationDetail {
  String recomendId;
  String fullname;
  String applyPosition;
  String applyDate;
  String email;
  String phone;
  int transactionStatusId;
  String transactionStatus;


  JobRecomendationDetail(this.recomendId, this.fullname, this.applyPosition,
      this.applyDate, this.email, this.phone, this.transactionStatusId, this.transactionStatus);

  JobRecomendationDetail.fromJson(Map<String, dynamic> json) {
    recomendId = json['id'].toString();
    fullname = json['fullName'];
    applyPosition = json['applyPosition'].toString();
    applyDate = json['applyDateString'];
    email = json['email'];
    phone = json['phone'];
    transactionStatusId = json['transactionID'];
    transactionStatus = json['transactionStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.recomendId;
    data['fullName'] = this.fullname;
    data['applyPosition'] = this.applyPosition;
    data['applyDateString'] = this.applyDate;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['transactionID'] = this.transactionStatusId;
    data['transactionStatus'] = this.transactionStatus;
    return data;
  }
}
