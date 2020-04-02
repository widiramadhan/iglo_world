class IssueComment {
  String commentId;
  String username;
  String fullName;
  String comment;
  String createDate;
  String filePath;


  IssueComment(this.commentId, this.username, this.fullName, this.comment, this.createDate, this.filePath);

  IssueComment.fromJson(Map<String, dynamic> json) {
    commentId = json['id'].toString();
    username = json['userName'];
    fullName = json['fullName'];
    comment = json['comment'];
    createDate = json['createDateString'];
    filePath = json['filePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.commentId;
    data['userName'] = this.username;
    data['fullName'] = this.fullName;
    data['comment'] = this.comment;
    data['createDateString'] = this.createDate;
    data['filePath'] = this.filePath;
    return data;
  }
}
