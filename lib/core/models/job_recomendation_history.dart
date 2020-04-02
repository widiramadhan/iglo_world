class JobRecomendationHistory {
  String statusName;
  String timestamp;
  String descriptionResult;


  JobRecomendationHistory(this.statusName, this.timestamp, this.descriptionResult);

  JobRecomendationHistory.fromJson(Map<String, dynamic> json) {
    statusName = json['statusName'];
    timestamp = json['timestampString'];
    descriptionResult = json['descriptionResult'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusName'] = this.statusName;
    data['timestampString'] = this.timestamp;
    data['descriptionResult'] = this.descriptionResult;
    return data;
  }
}
