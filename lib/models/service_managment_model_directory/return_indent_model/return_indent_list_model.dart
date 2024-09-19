class ReturnIndentListResponse {
  String? condition;
  int? totalCount;
  String? returnNo;
  String? locationCode;
  String? createdBy;
  String? createdOn;
  int? isDone;
  String? completedOn;

  ReturnIndentListResponse(
      {this.condition,
        this.totalCount,
        this.returnNo,
        this.locationCode,
        this.createdBy,
        this.createdOn,
        this.isDone,
        this.completedOn});

  ReturnIndentListResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalCount = json['total_count'];
    returnNo = json['return_no'];
    locationCode = json['location_code'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    isDone = json['is_done'];
    completedOn = json['completed_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_count'] = this.totalCount;
    data['return_no'] = this.returnNo;
    data['location_code'] = this.locationCode;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['is_done'] = this.isDone;
    data['completed_on'] = this.completedOn;
    return data;
  }
}