class Reward {
  String title;
  String description;
  String rewardDateString;
  String rewardType;
  String reward;


  Reward(this.title, this.description, this.rewardDateString, this.rewardType,
      this.reward);

  Reward.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    rewardDateString = json['rewardDateString'];
    rewardType = json['rewardType'].toString();
    reward = json['reward'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['description'] = this.description;
    data['rewardDateString'] = this.rewardDateString;
    data['rewardType'] = this.rewardType;
    data['reward'] = this.reward;
    return data;
  }
}
