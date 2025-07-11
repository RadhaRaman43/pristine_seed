class BusinessTourApprovalModel {
  String? condition;
  int? pendingCount;
  int? approvedCount;
  int? rejectedCount;
  int? totalRows;
  String? tourId;
  String? cluster;
  String? zone;
  String? region;
  String? frontliners;
  String? touringRegion;
  String? status;
  String? startDate;
  String? endDate;
  String? month;
  String? year;
  String? createdBy;
  String? createdOn;
  String? completedOn;
  String? rejectReason;
  String? approvedBy;
  String? approvedOn;
  String? reportingManager;
  String? accountCreateFullName;
  String? accountApproveFullName;

  BusinessTourApprovalModel(
      {this.condition,
        this.pendingCount,
        this.approvedCount,
        this.rejectedCount,
        this.totalRows,
        this.tourId,
        this.cluster,
        this.zone,
        this.region,
        this.frontliners,
        this.touringRegion,
        this.status,
        this.startDate,
        this.endDate,
        this.month,
        this.year,
        this.createdBy,
        this.createdOn,
        this.completedOn,
        this.rejectReason,
        this.approvedBy,
        this.approvedOn,
        this.reportingManager,
        this.accountCreateFullName,
        this.accountApproveFullName});

  BusinessTourApprovalModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    pendingCount = json['pending_count'];
    approvedCount = json['approved_count'];
    rejectedCount = json['rejected_count'];
    totalRows = json['total_rows'];
    tourId = json['tour_id'];
    cluster = json['cluster'];
    zone = json['zone'];
    region = json['region'];
    frontliners = json['frontliners'];
    touringRegion = json['touring_region'];
    status = json['status'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    month = json['month'];
    year = json['year'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    completedOn = json['completed_on'];
    rejectReason = json['reject_reason'];
    approvedBy = json['approved_by'];
    approvedOn = json['approved_on'];
    reportingManager = json['reporting_manager'];
    accountCreateFullName = json['account_create_full_name'];
    accountApproveFullName = json['account_approve_full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['pending_count'] = this.pendingCount;
    data['approved_count'] = this.approvedCount;
    data['rejected_count'] = this.rejectedCount;
    data['total_rows'] = this.totalRows;
    data['tour_id'] = this.tourId;
    data['cluster'] = this.cluster;
    data['zone'] = this.zone;
    data['region'] = this.region;
    data['frontliners'] = this.frontliners;
    data['touring_region'] = this.touringRegion;
    data['status'] = this.status;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['month'] = this.month;
    data['year'] = this.year;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['completed_on'] = this.completedOn;
    data['reject_reason'] = this.rejectReason;
    data['approved_by'] = this.approvedBy;
    data['approved_on'] = this.approvedOn;
    data['reporting_manager'] = this.reportingManager;
    data['account_create_full_name'] = this.accountCreateFullName;
    data['account_approve_full_name'] = this.accountApproveFullName;
    return data;
  }
}