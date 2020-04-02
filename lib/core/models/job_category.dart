class JobCategory {
  String jobCategoryId;
  String jobCategoryName;


  JobCategory(this.jobCategoryId, this.jobCategoryName);

  JobCategory.fromJson(Map<String, dynamic> json) {
    jobCategoryId = json['id'].toString();
    jobCategoryName = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.jobCategoryId;
    data['name'] = this.jobCategoryName;
    return data;
  }
}
