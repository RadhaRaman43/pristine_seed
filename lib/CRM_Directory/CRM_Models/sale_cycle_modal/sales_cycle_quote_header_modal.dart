class SalesCycleQuoteHeaderModal {
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
  String? sprNo;
  int? isReadyForApprove;
  int? isReadySendForApproval;
  double? quoteTotalAmount;
  double? quoteGrossAmount;
  double? quoteGstAmount;
  String? shippingAddress;
  String? shippingAddress2;
  String? shippingPostCode;
  String? shippingStateCode;
  String? shippingStateName;
  String? shippingCity;
  String? shippingDistrict;

  SalesCycleQuoteHeaderModal(
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
        this.sprNo,
        this.isReadyForApprove,
        this.isReadySendForApproval,
        this.quoteTotalAmount,
        this.quoteGrossAmount,
        this.quoteGstAmount,
        this.shippingAddress,
        this.shippingAddress2,
        this.shippingPostCode,
        this.shippingStateCode,
        this.shippingStateName,
        this.shippingCity,
        this.shippingDistrict});

  SalesCycleQuoteHeaderModal.fromJson(Map<String, dynamic> json) {
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
    sprNo = json['spr_no'];
    isReadyForApprove = json['is_ready_for_approve'];
    isReadySendForApproval = json['is_ready_send_for_approval'];
    quoteTotalAmount = json['quote_total_amount'];
    quoteGrossAmount = json['quote_gross_amount'];
    quoteGstAmount = json['quote_gst_amount'];
    shippingAddress = json['shipping_address'];
    shippingAddress2 = json['shipping_address2'];
    shippingPostCode = json['shipping_post_code'];
    shippingStateCode = json['shipping_state_code'];
    shippingStateName = json['shipping_state_name'];
    shippingCity = json['shipping_city'];
    shippingDistrict = json['shipping_district'];
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
    data['spr_no'] = this.sprNo;
    data['is_ready_for_approve'] = this.isReadyForApprove;
    data['is_ready_send_for_approval'] = this.isReadySendForApproval;
    data['quote_total_amount'] = this.quoteTotalAmount;
    data['quote_gross_amount'] = this.quoteGrossAmount;
    data['quote_gst_amount'] = this.quoteGstAmount;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_address2'] = this.shippingAddress2;
    data['shipping_post_code'] = this.shippingPostCode;
    data['shipping_state_code'] = this.shippingStateCode;
    data['shipping_state_name'] = this.shippingStateName;
    data['shipping_city'] = this.shippingCity;
    data['shipping_district'] = this.shippingDistrict;
    return data;
  }
}