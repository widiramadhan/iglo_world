class JobPosition {
  String jobId;
  String jobName;
  String jobCategoryId;
  String jobTypeId;
  String experience;
  String location;
  String offeredSalary;
  String jobDescription;
  String jobRequirment;
  String isActive;
  String createdBy;
  String createdDate;
  String updatedDate;
  String deletedDate;
  String jobCategory;
  String jobType;


  JobPosition(this.jobId, this.jobName, this.jobCategoryId, this.jobTypeId,
      this.experience, this.location, this.offeredSalary, this.jobDescription,
      this.jobRequirment, this.isActive, this.createdBy, this.createdDate,
      this.updatedDate, this.deletedDate, this.jobCategory, this.jobType);

  JobPosition.fromJson(Map<String, dynamic> json) {
    jobId = json['id'].toString();
    jobName = json['name'];
    jobCategoryId = json['jobCategoryId'].toString();
    jobTypeId = json['jobTypeId'].toString();
    experience = json['experience'];
    location = json['location'];
    offeredSalary = json['offeredSalaryString'].toString();
    jobDescription = json['jobDescription'];
    jobRequirment = json['jobRequirment'];
    isActive = json['isActive'].toString();
    createdBy = json['createdBy'];
    createdDate = json['createDateString'];
    updatedDate = json['updateDateString'];
    deletedDate = json['deleteDateString'];
    jobCategory = json['jobCategory'];
    jobType = json['jobType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.jobId;
    data['name'] = this.jobName;
    data['jobCategoryId'] = this.jobCategoryId;
    data['jobTypeId'] = this.jobTypeId;
    data['experience'] = this.experience;
    data['location'] = this.location;
    data['offeredSalary'] = this.offeredSalary;
    data['jobDescription'] = this.jobDescription;
    data['jobRequirment'] = this.jobRequirment;
    data['isActive'] = this.isActive;
    data['createdBy'] = this.createdBy;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    data['deletedDate'] = this.deletedDate;
    data['jobCategory'] = this.jobCategory;
    data['jobType'] = this.jobType;
    return data;
  }
}
