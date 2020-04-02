class IssueDetail {
  String issueId;
  String issue;
  String subject;
  String description;
  String createdBy;
  String picName;
  String transactionStatus;
  String openTicketDate;
  String ticketExpireDate;


  IssueDetail(this.issueId, this.issue, this.subject, this.description,
      this.createdBy, this.picName, this.transactionStatus,
      this.openTicketDate, this.ticketExpireDate);

  IssueDetail.fromJson(Map<String, dynamic> json) {
    issueId = json['id'].toString();
    issue = json['issue'];
    subject = json['subject'];
    description = json['description'];
    createdBy = json['createdBy'];
    picName = json['picName'];
    transactionStatus = json['transactionStatus'].toString();
    openTicketDate = json['openTicketDateString'];
    ticketExpireDate = json['ticketExpireDateString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.issueId;
    data['issueName'] = this.issue;
    data['subject'] = this.subject;
    data['description'] = this.description;
    data['createdBy'] = this.createdBy;
    data['picName'] = this.picName;
    data['transactionStatus'] = this.transactionStatus;
    data['openTicketDateString'] = this.openTicketDate;
    data['ticketExpireDateString'] = this.ticketExpireDate;
    return data;
  }
}
