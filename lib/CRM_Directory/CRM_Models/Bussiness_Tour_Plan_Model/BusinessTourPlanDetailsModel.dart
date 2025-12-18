class BusinessTourPlanDetailsModel {
  String? condition;
  String? message;
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
  String? completedOn;
  dynamic? rejectReason;
  dynamic? approvedBy;
  dynamic? approvedOn;
  String? reportingManager;
  String? createdFullName;
  String? approvedFullName;
  String? reportingFullName;
  List<Lines>? lines;

  BusinessTourPlanDetailsModel(
      {this.condition,
        this.message,
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
        this.reportingFullName,
        this.lines});

  BusinessTourPlanDetailsModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
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
    if (json['lines'] != dynamic) {
      lines = <Lines>[];
      json['lines'].forEach((v) {
        lines!.add(new Lines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
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
    if (this.lines != dynamic) {
      data['lines'] = this.lines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lines {
  String? tourId;
  String? lineNo;
  String? touringDistrict;
  String? tourDate;
  String? tourType;
  String? accompaniedWith;
  String? customer;
  String? meetingWith;
  String? objective;
  String? remark;
  String? createdOn;
  String? customerName;

  Lines(
      {this.tourId,
        this.lineNo,
        this.touringDistrict,
        this.tourDate,
        this.tourType,
        this.accompaniedWith,
        this.customer,
        this.meetingWith,
        this.objective,
        this.remark,
        this.createdOn,
        this.customerName});

  Lines.fromJson(Map<String, dynamic> json) {
    tourId = json['tour_id'];
    lineNo = json['line_no'];
    touringDistrict = json['touring_district'];
    tourDate = json['tour_date'];
    tourType = json['tour_type'];
    accompaniedWith = json['accompanied_with'];
    customer = json['customer'];
    meetingWith = json['meeting_with'];
    objective = json['objective'];
    remark = json['remark'];
    createdOn = json['created_on'];
    customerName = json['customer_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tour_id'] = this.tourId;
    data['line_no'] = this.lineNo;
    data['touring_district'] = this.touringDistrict;
    data['tour_date'] = this.tourDate;
    data['tour_type'] = this.tourType;
    data['accompanied_with'] = this.accompaniedWith;
    data['customer'] = this.customer;
    data['meeting_with'] = this.meetingWith;
    data['objective'] = this.objective;
    data['remark'] = this.remark;
    data['created_on'] = this.createdOn;
    data['customer_name'] = this.customerName;
    return data;
  }
}