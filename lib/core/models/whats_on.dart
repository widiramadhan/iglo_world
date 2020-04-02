class WhatsOn {
  String id;
  String title;
  String story;
  String createdBy;
  String createdDatetimeString;
  String imageSource;
  //String base64Image;


  WhatsOn(this.id, this.title, this.story, this.createdBy,
      this.createdDatetimeString, this.imageSource);//this.base64Image);

  WhatsOn.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    title = json['title'];
    story = json['story'];
    createdBy = json['createdBy'];
    createdDatetimeString = json['createdDatetimeString'];
    imageSource = json['filePath'];
    //base64Image = json['imageSource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['story'] = this.story;
    data['createdBy'] = this.createdBy;
    data['createdDatetimeString'] = this.createdDatetimeString;
    data['filePath'] = this.imageSource;
    //data['base64Image'] = this.base64Image;
    return data;
  }
}
