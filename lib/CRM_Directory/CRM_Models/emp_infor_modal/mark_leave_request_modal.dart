class MarkLeaveRequestModal {
  String? condition;
  String? message;
  int? pendingCount;
  int? approvedCount;
  int? rejectedCount;
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
  String? finalApprovedBy;
  String? approvedFromDate;
  String? approvedToDate;
  int? noOfApprovedDays;
  String? approvedLeaveCode;
  String? managerRemarks;
  String? createdFullName;
  String? approvedFullName;
  String? finalApprovedFullName;
  String? leaveDescription;
  String? approvedLeaveDescription;

  MarkLeaveRequestModal(
      {this.condition,
        this.message,
        this.pendingCount,
        this.approvedCount,
        this.rejectedCount,
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
        this.finalApprovedBy,
        this.approvedFromDate,
        this.approvedToDate,
        this.noOfApprovedDays,
        this.approvedLeaveCode,
        this.managerRemarks,
        this.createdFullName,
        this.approvedFullName,
        this.finalApprovedFullName,
        this.leaveDescription,
        this.approvedLeaveDescription});

  MarkLeaveRequestModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    pendingCount = json['pending_count'];
    approvedCount = json['approved_count'];
    rejectedCount = json['rejected_count'];
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
    finalApprovedBy = json['final_approved_by'];
    approvedFromDate = json['approved_from_date'];
    approvedToDate = json['approved_to_date'];
    noOfApprovedDays = json['no_of_approved_days'];
    approvedLeaveCode = json['approved_leave_code'];
    managerRemarks = json['manager_remarks'];
    createdFullName = json['created_full_name'];
    approvedFullName = json['approved_full_name'];
    finalApprovedFullName = json['final_approved_full_name'];
    leaveDescription = json['leave_description'];
    approvedLeaveDescription = json['approved_leave_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['pending_count'] = this.pendingCount;
    data['approved_count'] = this.approvedCount;
    data['rejected_count'] = this.rejectedCount;
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
    data['final_approved_by'] = this.finalApprovedBy;
    data['approved_from_date'] = this.approvedFromDate;
    data['approved_to_date'] = this.approvedToDate;
    data['no_of_approved_days'] = this.noOfApprovedDays;
    data['approved_leave_code'] = this.approvedLeaveCode;
    data['manager_remarks'] = this.managerRemarks;
    data['created_full_name'] = this.createdFullName;
    data['approved_full_name'] = this.approvedFullName;
    data['final_approved_full_name'] = this.finalApprovedFullName;
    data['leave_description'] = this.leaveDescription;
    data['approved_leave_description'] = this.approvedLeaveDescription;
    return data;
  }
}