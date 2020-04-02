class IssueProgress {
  String issueId;
  String issueName;
  String subject;
  String description;
  String status;
  String dateString;


  IssueProgress(this.issueId, this.issueName, this.subject, this.description, this.status, this.dateString);

  IssueProgress.fromJson(Map<String, dynamic> json) {
    issueId = json['id'].toString();
    issueName = json['issueName'];
    subject = json['subject'];
    description = json['description'];
    status = json['status'];
    dateString = json['dateString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.issueId;
    data['issueName'] = this.issueName;
    data['subject'] = this.subject;
    data['description'] = this.description;
    data['status'] = this.status;
    data['dateString'] = this.dateString;
    return data;
  }
}
