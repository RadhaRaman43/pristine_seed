class BulkIndentListModel {
  String? condition;
  String? message;
  int? totalCount;
  String? indentType;
  String? indentNo;
  String? serviceType;
  String? serviceId;
  String? serviceNo;
  String? createdOn;
  String? createdBy;
  String? indentStatus;
  String? updatedOn;
  String? completedOn;
  String? approveOn;
  String? approveBy;
  String? rejectReason;
  String? locationCode;

  BulkIndentListModel(
      {this.condition,
        this.message,
        this.totalCount,
        this.indentType,
        this.indentNo,
        this.serviceType,
        this.serviceId,
        this.serviceNo,
        this.createdOn,
        this.createdBy,
        this.indentStatus,
        this.updatedOn,
        this.completedOn,
        this.approveOn,
        this.approveBy,
        this.rejectReason,
        this.locationCode});

  BulkIndentListModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    totalCount = json['total_count'];
    indentType = json['indent_type'];
    indentNo = json['indent_no'];
    serviceType = json['service_type'];
    serviceId = json['service_id'];
    serviceNo = json['service_no'];
    createdOn = json['created_on'];
    createdBy = json['created_by'];
    indentStatus = json['indent_status'];
    updatedOn = json['updated_on'];
    completedOn = json['completed_on'];
    approveOn = json['approve_on'];
    approveBy = json['approve_by'];
    rejectReason = json['reject_reason'];
    locationCode = json['location_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['total_count'] = this.totalCount;
    data['indent_type'] = this.indentType;
    data['indent_no'] = this.indentNo;
    data['service_type'] = this.serviceType;
    data['service_id'] = this.serviceId;
    data['service_no'] = this.serviceNo;
    data['created_on'] = this.createdOn;
    data['created_by'] = this.createdBy;
    data['indent_status'] = this.indentStatus;
    data['updated_on'] = this.updatedOn;
    data['completed_on'] = this.completedOn;
    data['approve_on'] = this.approveOn;
    data['approve_by'] = this.approveBy;
    data['reject_reason'] = this.rejectReason;
    data['location_code'] = this.locationCode;
    return data;
  }
}