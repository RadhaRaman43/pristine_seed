/*
class BussinessTourPlanModel {
  String? condition;
  String? message;
  String? totalRows;
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
  String? createdFullName;
  String? approvedFullName;

  BussinessTourPlanModel(
      {this.condition,
        this.message,
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
        this.createdFullName,
        this.approvedFullName});

  BussinessTourPlanModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
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
    createdFullName = json['created_full_name'];
    approvedFullName = json['approved_full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
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
    data['created_full_name'] = this.createdFullName;
    data['approved_full_name'] = this.approvedFullName;
    return data;
  }
}*/

class BussinessTourPlanModel {
  String? condition;
  String? message;
  String? totalRows;
  String? tourId;
  String? cluster;
  String? zone;
  String? region;
  String? frontliners;
  String? touringRegion;
  String? status;
  String? startDate;
  String? endDate;
  dynamic? month;
  dynamic? year;
  String? createdBy;
  String? createdOn;
  dynamic? completedOn;
  dynamic? rejectReason;
  dynamic? approvedBy;
  dynamic? approvedOn;
  String? reportingManager;
  String? createdFullName;
  String? approvedFullName;
  String? reportingFullName;

  BussinessTourPlanModel(
      {this.condition,
        this.message,
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
        this.createdFullName,
        this.approvedFullName,
        this.reportingFullName});

  BussinessTourPlanModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
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
    createdFullName = json['created_full_name'];
    approvedFullName = json['approved_full_name'];
    reportingFullName = json['reporting_full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
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
    data['created_full_name'] = this.createdFullName;
    data['approved_full_name'] = this.approvedFullName;
    data['reporting_full_name'] = this.reportingFullName;
    return data;
  }
}