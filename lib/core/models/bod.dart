class BodQuote {
  String id;
  String quote;
  String position;
  String author;
  String images;


  BodQuote(this.id, this.quote, this.position, this.author,
      this.images);

  BodQuote.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    quote = json['quote'];
    position = json['position'];
    author = json['author'];
    images = json['imageSource'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['quote'] = this.quote;
    data['position'] = this.position;
    data['author'] = this.author;
    data['imageSource'] = this.images;
    return data;
  }
}
