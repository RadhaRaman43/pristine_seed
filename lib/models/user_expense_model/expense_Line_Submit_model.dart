class ExpenseLinesSubmittedResponse {
  String? condition;
  String? message;
  String? status;
  String? documentNo;
  String? grade;
  String? createdBy;
  String? createdOn;
  String? daCode;
  String? daName;
  double? totalLineAmount;
  double? daAmount;
  String? remarks;
  String? expenseDate;
  int? isDone;
  String? completedOn;
  int? isApprove;
  String? approveStatus;
  String? approveBy;
  String? approveOn;
  List<Lines>? lines;

  ExpenseLinesSubmittedResponse(
      {this.condition,
        this.message,
        this.status,
        this.documentNo,
        this.grade,
        this.createdBy,
        this.createdOn,
        this.daCode,
        this.daName,
        this.daAmount,
        this.totalLineAmount,
        this.remarks,
        this.expenseDate,
        this.isDone,
        this.completedOn,
        this.isApprove,
        this.approveStatus,
        this.approveBy,
        this.approveOn,
        this.lines});

  ExpenseLinesSubmittedResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    status = json['status'];
    documentNo = json['document_no'];
    grade = json['grade'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    daCode = json['da_code'];
    daName = json['da_name'];
    daAmount = json['da_amount'];
    totalLineAmount = json['total_line_amount'];
    remarks = json['remarks'];
    expenseDate = json['expense_date'];
    isDone = json['is_done'];
    completedOn = json['completed_on'];
    isApprove = json['is_approve'];
    approveStatus = json['approve_status'];
    approveBy = json['approve_by'];
    approveOn = json['approve_on'];
    if (json['lines'] != null) {
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
    data['status'] = this.status;
    data['document_no'] = this.documentNo;
    data['grade'] = this.grade;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['da_code'] = this.daCode;
    data['da_name'] = this.daName;
    data['da_amount'] = this.daAmount;
    data['total_line_amount'] = this.totalLineAmount;
    data['remarks'] = this.remarks;
    data['expense_date'] = this.expenseDate;
    data['is_done'] = this.isDone;
    data['completed_on'] = this.completedOn;
    data['is_approve'] = this.isApprove;
    data['approve_status'] = this.approveStatus;
    data['approve_by'] = this.approveBy;
    data['approve_on'] = this.approveOn;
    if (this.lines != null) {
      data['lines'] = this.lines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lines {
  String? documentNo;
  int? expenseId;
  String? expenseName;
  double? expenseAmount;
  String? imageUrl;
  String? imageUrl1;
  String? imageUrl2;
  String? imageUrl3;
  int? imageCount;
  String? expenseRemark;
  String? lodgingFromDate;
  String? lodgingToDate;
  String? regionCode;
  String? regionName;
  double? totalKmTravel;
  int? isLodging;
  int? isKm;

  Lines(
      {this.documentNo,
        this.expenseId,
        this.expenseName,
        this.expenseAmount,
        this.imageUrl,
        this.imageUrl1,
        this.imageUrl2,
        this.imageUrl3,
        this.imageCount,
        this.expenseRemark,
        this.lodgingFromDate,
        this.lodgingToDate,
        this.regionCode,
        this.regionName,
        this.totalKmTravel,
        this.isLodging,
        this.isKm
      });

  Lines.fromJson(Map<String, dynamic> json) {
    documentNo = json['document_no'];
    expenseId = json['expense_id'];
    expenseName = json['expense_name'];
    expenseAmount = json['expense_amount'];
    imageUrl = json['image_url'];
    imageUrl1 = json['image_url1'];
    imageUrl2 = json['image_url2'];
    imageUrl3 = json['image_url3'];
    imageCount = json['image_count'];
    expenseRemark = json['expense_remark'];
    lodgingFromDate = json['lodging_from_date'];
    lodgingToDate = json['lodging_to_date'];
    regionCode = json['region_code'];
    regionName = json['region_name'];
    totalKmTravel = json['total_km_travel'];
    isLodging = json['is_lodging'];
    isKm = json['is_km'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_no'] = this.documentNo;
    data['expense_id'] = this.expenseId;
    data['expense_name'] = this.expenseName;
    data['expense_amount'] = this.expenseAmount;
    data['image_url'] = this.imageUrl;
    data['image_url1'] = this.imageUrl1;
    data['image_url2'] = this.imageUrl2;
    data['image_url3'] = this.imageUrl3;
    data['image_count'] = this.imageCount;
    data['expense_remark'] = this.expenseRemark;
    data['lodging_from_date'] = this.lodgingFromDate;
    data['lodging_to_date'] = this.lodgingToDate;
    data['region_code'] = this.regionCode;
    data['region_name'] = this.regionName;
    data['total_km_travel'] = this.totalKmTravel;
    data['is_lodging'] = this.isLodging;
    data['is_km'] = this.isKm;
    return data;
  }
}