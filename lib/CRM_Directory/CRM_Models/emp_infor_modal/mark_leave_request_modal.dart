class MarkLeaveRequestModal {
  String? condition;
  String? message;
  int? rowCount;
  String? leaveId;
  String? locationCode;
  String? fromDate;
  String? toDate;
  int? noOfDays;
  String? status;
  String? leaveCode;
  String? leaveReason;
  String? region;
  String? clusture;
  String? createdBy;
  String? createdOn;
  String? approvedBy;
  String? approvedOn;
  String? rejectRemarks;
  String? approvedFromDate;
  String? approvedToDate;
  int? noOfApprovedDays;
  String? approvedLeaveCode;
  String? managerRemarks;
  String? createdFullName;
  String? approvedFullName;
  String? leaveDescription;

  MarkLeaveRequestModal(
      {this.condition,
        this.message,
        this.rowCount,
        this.leaveId,
        this.locationCode,
        this.fromDate,
        this.toDate,
        this.noOfDays,
        this.status,
        this.leaveCode,
        this.leaveReason,
        this.region,
        this.clusture,
        this.createdBy,
        this.createdOn,
        this.approvedBy,
        this.approvedOn,
        this.rejectRemarks,
        this.approvedFromDate,
        this.approvedToDate,
        this.noOfApprovedDays,
        this.approvedLeaveCode,
        this.managerRemarks,
        this.createdFullName,
        this.approvedFullName,
        this.leaveDescription});

  MarkLeaveRequestModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    rowCount = json['row_count'];
    leaveId = json['leave_id'];
    locationCode = json['location_code'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    noOfDays = json['no_of_days'];
    status = json['status'];
    leaveCode = json['leave_code'];
    leaveReason = json['leave_reason'];
    region = json['region'];
    clusture = json['clusture'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    approvedBy = json['approved_by'];
    approvedOn = json['approved_on'];
    rejectRemarks = json['reject_remarks'];
    approvedFromDate = json['approved_from_date'];
    approvedToDate = json['approved_to_date'];
    noOfApprovedDays = json['no_of_approved_days'];
    approvedLeaveCode = json['approved_leave_code'];
    managerRemarks = json['manager_remarks'];
    createdFullName = json['created_full_name'];
    approvedFullName = json['approved_full_name'];
    leaveDescription = json['leave_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['row_count'] = this.rowCount;
    data['leave_id'] = this.leaveId;
    data['location_code'] = this.locationCode;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['no_of_days'] = this.noOfDays;
    data['status'] = this.status;
    data['leave_code'] = this.leaveCode;
    data['leave_reason'] = this.leaveReason;
    data['region'] = this.region;
    data['clusture'] = this.clusture;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['approved_by'] = this.approvedBy;
    data['approved_on'] = this.approvedOn;
    data['reject_remarks'] = this.rejectRemarks;
    data['approved_from_date'] = this.approvedFromDate;
    data['approved_to_date'] = this.approvedToDate;
    data['no_of_approved_days'] = this.noOfApprovedDays;
    data['approved_leave_code'] = this.approvedLeaveCode;
    data['manager_remarks'] = this.managerRemarks;
    data['created_full_name'] = this.createdFullName;
    data['approved_full_name'] = this.approvedFullName;
    data['leave_description'] = this.leaveDescription;
    return data;
  }
}


