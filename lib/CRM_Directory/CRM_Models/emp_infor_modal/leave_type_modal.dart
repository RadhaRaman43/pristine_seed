class LeaveTypeModel {
  String? condtion;
  String? message;
  String? leaveCode;
  String? description;
  int? isAdditionalFieldRequired;
  int? annualAvailable;
  int? monthAvailable;
  int? maxLeave;
  String? createdBy;
  String? createdOn;

  LeaveTypeModel(
      {this.condtion,
        this.message,
        this.leaveCode,
        this.description,
        this.isAdditionalFieldRequired,
        this.annualAvailable,
        this.monthAvailable,
        this.maxLeave,
        this.createdBy,
        this.createdOn});

  LeaveTypeModel.fromJson(Map<String, dynamic> json) {
    condtion = json['condtion'];
    message = json['message'];
    leaveCode = json['leave_code'];
    description = json['description'];
    isAdditionalFieldRequired = json['is_additional_field_required'];
    annualAvailable = json['annual_available'];
    monthAvailable = json['month_available'];
    maxLeave = json['max_leave'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condtion'] = this.condtion;
    data['message'] = this.message;
    data['leave_code'] = this.leaveCode;
    data['description'] = this.description;
    data['is_additional_field_required'] = this.isAdditionalFieldRequired;
    data['annual_available'] = this.annualAvailable;
    data['month_available'] = this.monthAvailable;
    data['max_leave'] = this.maxLeave;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    return data;
  }
}