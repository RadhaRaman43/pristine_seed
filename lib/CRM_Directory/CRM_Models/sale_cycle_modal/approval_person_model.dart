class getApprovalPersonMadol {
  String? condition;
  int? approverOrder;
  String? quoteStatus;
  String? approvedBy;
  String? approvedFullName;
  String? approvedOn;
  String? rejectReason;
  int? isSpr;
  String? sprNo;
  String? sprCategoryCode;
  String? sprCategoryName;
  String? approverGeoName;
  String? approverGeoValue;
  String? userType;

  getApprovalPersonMadol(
      {this.condition,
        this.approverOrder,
        this.quoteStatus,
        this.approvedBy,
        this.approvedFullName,
        this.approvedOn,
        this.rejectReason,
        this.isSpr,
        this.sprNo,
        this.sprCategoryCode,
        this.sprCategoryName,
        this.approverGeoName,
        this.approverGeoValue,
        this.userType});

  getApprovalPersonMadol.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    approverOrder = json['approver_order'];
    quoteStatus = json['quote_status'];
    approvedBy = json['approved_by'];
    approvedFullName = json['approved_full_name'];
    approvedOn = json['approved_on'];
    rejectReason = json['reject_reason'];
    isSpr = json['is_spr'];
    sprNo = json['spr_no'];
    sprCategoryCode = json['spr_category_code'];
    sprCategoryName = json['spr_category_name'];
    approverGeoName = json['approver_geo_name'];
    approverGeoValue = json['approver_geo_value'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['approver_order'] = this.approverOrder;
    data['quote_status'] = this.quoteStatus;
    data['approved_by'] = this.approvedBy;
    data['approved_full_name'] = this.approvedFullName;
    data['approved_on'] = this.approvedOn;
    data['reject_reason'] = this.rejectReason;
    data['is_spr'] = this.isSpr;
    data['spr_no'] = this.sprNo;
    data['spr_category_code'] = this.sprCategoryCode;
    data['spr_category_name'] = this.sprCategoryName;
    data['approver_geo_name'] = this.approverGeoName;
    data['approver_geo_value'] = this.approverGeoValue;
    data['user_type'] = this.userType;
    return data;
  }
}