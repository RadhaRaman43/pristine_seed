class QuoteWonModel {
  String? condition;
  String? totalRows;
  String? quoteId;
  String? salesCycleId;
  double? quoteVersion;
  String? accountCode;
  String? accountName;
  String? contactCode;
  String? contactName;
  String? quoteValidity;
  String? expClosureDate;
  int? quoteCommit;
  String? quoteStatus;
  int? isActive;
  double? installationCharges;
  double? otherCharges;
  String? warrantyPeriod;
  String? deliveryInWeeks;
  double? advancePaymentPer;
  double? advancePaymentAmt;
  String? otherRemarks;
  int? isSpr;
  String? sprNo;
  String? sprDate;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;
  String? regretBy;
  String? regretOn;
  String? regretReason;
  String? approvedBy;
  String? approvedOn;
  String? rejectReason;
  String? consigneeId;

  QuoteWonModel(
      {this.condition,
        this.totalRows,
        this.quoteId,
        this.salesCycleId,
        this.quoteVersion,
        this.accountCode,
        this.accountName,
        this.contactCode,
        this.contactName,
        this.quoteValidity,
        this.expClosureDate,
        this.quoteCommit,
        this.quoteStatus,
        this.isActive,
        this.installationCharges,
        this.otherCharges,
        this.warrantyPeriod,
        this.deliveryInWeeks,
        this.advancePaymentPer,
        this.advancePaymentAmt,
        this.otherRemarks,
        this.isSpr,
        this.sprNo,
        this.sprDate,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
        this.regretBy,
        this.regretOn,
        this.regretReason,
        this.approvedBy,
        this.approvedOn,
        this.rejectReason,
        this.consigneeId});

  QuoteWonModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    quoteId = json['quote_id'];
    salesCycleId = json['sales_cycle_id'];
    quoteVersion = json['quote_version'];
    accountCode = json['account_code'];
    accountName = json['account_name'];
    contactCode = json['contact_code'];
    contactName = json['contact_name'];
    quoteValidity = json['quote_validity'];
    expClosureDate = json['exp_closure_date'];
    quoteCommit = json['quote_commit'];
    quoteStatus = json['quote_status'];
    isActive = json['is_active'];
    installationCharges = json['installation_charges'];
    otherCharges = json['other_charges'];
    warrantyPeriod = json['warranty_period'];
    deliveryInWeeks = json['delivery_in_weeks'];
    advancePaymentPer = json['advance_payment_per'];
    advancePaymentAmt = json['advance_payment_amt'];
    otherRemarks = json['other_remarks'];
    isSpr = json['is_spr'];
    sprNo = json['spr_no'];
    sprDate = json['spr_date'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
    regretBy = json['regret_by'];
    regretOn = json['regret_on'];
    regretReason = json['regret_reason'];
    approvedBy = json['approved_by'];
    approvedOn = json['approved_on'];
    rejectReason = json['reject_reason'];
    consigneeId = json['consignee_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['quote_id'] = this.quoteId;
    data['sales_cycle_id'] = this.salesCycleId;
    data['quote_version'] = this.quoteVersion;
    data['account_code'] = this.accountCode;
    data['account_name'] = this.accountName;
    data['contact_code'] = this.contactCode;
    data['contact_name'] = this.contactName;
    data['quote_validity'] = this.quoteValidity;
    data['exp_closure_date'] = this.expClosureDate;
    data['quote_commit'] = this.quoteCommit;
    data['quote_status'] = this.quoteStatus;
    data['is_active'] = this.isActive;
    data['installation_charges'] = this.installationCharges;
    data['other_charges'] = this.otherCharges;
    data['warranty_period'] = this.warrantyPeriod;
    data['delivery_in_weeks'] = this.deliveryInWeeks;
    data['advance_payment_per'] = this.advancePaymentPer;
    data['advance_payment_amt'] = this.advancePaymentAmt;
    data['other_remarks'] = this.otherRemarks;
    data['is_spr'] = this.isSpr;
    data['spr_no'] = this.sprNo;
    data['spr_date'] = this.sprDate;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    data['regret_by'] = this.regretBy;
    data['regret_on'] = this.regretOn;
    data['regret_reason'] = this.regretReason;
    data['approved_by'] = this.approvedBy;
    data['approved_on'] = this.approvedOn;
    data['reject_reason'] = this.rejectReason;
    data['consignee_id'] = this.consigneeId;
    return data;
  }
}