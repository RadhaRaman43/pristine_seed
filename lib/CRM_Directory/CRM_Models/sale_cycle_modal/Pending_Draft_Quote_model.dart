
class Pending_Draft_Quote_Model {
  String? condition;
  String? totalRows;
  String? quoteId;
  double? quoteVersion;
  String? salesCycleId;
  String? accountCode;
  String? accountName;
  String? contactCode;
  String? contactName;
  String? productCategory;
  String? quoteStatus;
  String? quoteValidity;
  String? expClosureDate;
  int? quoteCommit;
  String? approvedBy;
  String? approvedFullName;
  String? approvedOn;
  String? rejectReason;
  String? createdBy;
  String? createdFullName;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;
  String? regretBy;
  String? regretOn;
  String? regretReason;
  int? isActive;
  double? installationCharges;
  double? otherCharges;
  String? warrantyPeriod;
  String? deliveryInWeeks;
  double? advancePaymentPer;
  double? advancePaymentAmt;
  String? otherRemarks;
  int? isSpr;
  int? noOfSalesAdvice;
  int? isSalesAdviceCreated;
  String? sprNo;
  int? isReadyForApprove;
  int? isReadySendForApproval;
  double? quoteTotalAmount;
  double? quoteGrossAmount;
  double? quoteGstAmount;

  Pending_Draft_Quote_Model(
      {this.condition,
        this.totalRows,
        this.quoteId,
        this.quoteVersion,
        this.salesCycleId,
        this.accountCode,
        this.accountName,
        this.contactCode,
        this.contactName,
        this.productCategory,
        this.quoteStatus,
        this.quoteValidity,
        this.expClosureDate,
        this.quoteCommit,
        this.approvedBy,
        this.approvedFullName,
        this.approvedOn,
        this.rejectReason,
        this.createdBy,
        this.createdFullName,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
        this.regretBy,
        this.regretOn,
        this.regretReason,
        this.isActive,
        this.installationCharges,
        this.otherCharges,
        this.warrantyPeriod,
        this.deliveryInWeeks,
        this.advancePaymentPer,
        this.advancePaymentAmt,
        this.otherRemarks,
        this.isSpr,
        this.noOfSalesAdvice,
        this.isSalesAdviceCreated,
        this.sprNo,
        this.isReadyForApprove,
        this.isReadySendForApproval,
        this.quoteTotalAmount,
        this.quoteGrossAmount,
        this.quoteGstAmount});

  Pending_Draft_Quote_Model.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    quoteId = json['quote_id'];
    quoteVersion = json['quote_version'];
    salesCycleId = json['sales_cycle_id'];
    accountCode = json['account_code'];
    accountName = json['account_name'];
    contactCode = json['contact_code'];
    contactName = json['contact_name'];
    productCategory = json['product_category'];
    quoteStatus = json['quote_status'];
    quoteValidity = json['quote_validity'];
    expClosureDate = json['exp_closure_date'];
    quoteCommit = json['quote_commit'];
    approvedBy = json['approved_by'];
    approvedFullName = json['approved_full_name'];
    approvedOn = json['approved_on'];
    rejectReason = json['reject_reason'];
    createdBy = json['created_by'];
    createdFullName = json['created_full_name'];
    createdOn = json['created_on'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
    regretBy = json['regret_by'];
    regretOn = json['regret_on'];
    regretReason = json['regret_reason'];
    isActive = json['is_active'];
    installationCharges = json['installation_charges'];
    otherCharges = json['other_charges'];
    warrantyPeriod = json['warranty_period'];
    deliveryInWeeks = json['delivery_in_weeks'];
    advancePaymentPer = json['advance_payment_per'];
    advancePaymentAmt = json['advance_payment_amt'];
    otherRemarks = json['other_remarks'];
    isSpr = json['is_spr'];
    noOfSalesAdvice = json['no_of_sales_advice'];
    isSalesAdviceCreated = json['is_sales_advice_created'];
    sprNo = json['spr_no'];
    isReadyForApprove = json['is_ready_for_approve'];
    isReadySendForApproval = json['is_ready_send_for_approval'];
    quoteTotalAmount = json['quote_total_amount'];
    quoteGrossAmount = json['quote_gross_amount'];
    quoteGstAmount = json['quote_gst_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['quote_id'] = this.quoteId;
    data['quote_version'] = this.quoteVersion;
    data['sales_cycle_id'] = this.salesCycleId;
    data['account_code'] = this.accountCode;
    data['account_name'] = this.accountName;
    data['contact_code'] = this.contactCode;
    data['contact_name'] = this.contactName;
    data['product_category'] = this.productCategory;
    data['quote_status'] = this.quoteStatus;
    data['quote_validity'] = this.quoteValidity;
    data['exp_closure_date'] = this.expClosureDate;
    data['quote_commit'] = this.quoteCommit;
    data['approved_by'] = this.approvedBy;
    data['approved_full_name'] = this.approvedFullName;
    data['approved_on'] = this.approvedOn;
    data['reject_reason'] = this.rejectReason;
    data['created_by'] = this.createdBy;
    data['created_full_name'] = this.createdFullName;
    data['created_on'] = this.createdOn;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    data['regret_by'] = this.regretBy;
    data['regret_on'] = this.regretOn;
    data['regret_reason'] = this.regretReason;
    data['is_active'] = this.isActive;
    data['installation_charges'] = this.installationCharges;
    data['other_charges'] = this.otherCharges;
    data['warranty_period'] = this.warrantyPeriod;
    data['delivery_in_weeks'] = this.deliveryInWeeks;
    data['advance_payment_per'] = this.advancePaymentPer;
    data['advance_payment_amt'] = this.advancePaymentAmt;
    data['other_remarks'] = this.otherRemarks;
    data['is_spr'] = this.isSpr;
    data['no_of_sales_advice'] = this.noOfSalesAdvice;
    data['is_sales_advice_created'] = this.isSalesAdviceCreated;
    data['spr_no'] = this.sprNo;
    data['is_ready_for_approve'] = this.isReadyForApprove;
    data['is_ready_send_for_approval'] = this.isReadySendForApproval;
    data['quote_total_amount'] = this.quoteTotalAmount;
    data['quote_gross_amount'] = this.quoteGrossAmount;
    data['quote_gst_amount'] = this.quoteGstAmount;
    return data;
  }
}