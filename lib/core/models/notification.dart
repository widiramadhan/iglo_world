class Notifications {
  String id;
  String categoryId;
  String categoryName;
  String title;
  String notificationDateString;
  String isRead;
  String notificationColor;
  String notificationIcon;


  Notifications(this.id, this.categoryId, this.categoryName, this.title,
      this.notificationDateString, this.isRead, this.notificationColor, this.notificationIcon);

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    categoryId = json['categoryId'].toString();
    categoryName = json['categoryName'];
    title = json['title'];
    notificationDateString = json['notificationDateString'];
    isRead = json['isRead'].toString();
    notificationColor = json['notificationColor'];
    notificationIcon = json['notificationIcon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryId'] = this.categoryId;
    data['categoryName'] = this.categoryName;
    data['title'] = this.title;
    data['notificationDateString'] = this.notificationDateString;
    data['isRead'] = this.isRead;
    data['notificationColor'] = this.notificationColor;
    data['notificationIcon'] = this.notificationIcon;
    return data;
  }
}
