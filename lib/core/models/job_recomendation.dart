class JobRecomendation {
  String recomendId;
  String fullname;
  String applyPosition;
  String applyDate;
  int transactionId;
  String transactionStatus;


  JobRecomendation(this.recomendId, this.fullname, this.applyPosition,
      this.applyDate, this.transactionStatus);

  JobRecomendation.fromJson(Map<String, dynamic> json) {
    recomendId = json['id'].toString();
    fullname = json['fullName'];
    applyPosition = json['applyPosition'].toString();
    applyDate = json['applyDateString'];
    transactionId = json['transactionID'];
    transactionStatus = json['transactionStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.recomendId;
    data['fullName'] = this.fullname;
    data['applyPosition'] = this.applyPosition;
    data['applyDateString'] = this.applyDate;
    data['transactionID'] = this.transactionId;
    data['transactionStatus'] = this.transactionStatus;
    return data;
  }
}
