class SalesCycleQuoteHeaderModal {
  String? condition;
  String? totalRows;
  String? quoteId;
  dynamic? quoteVersion;
  String? salesCycleId;
  String? accountCode;
  String? accountName;
  String? contactCode;
  String? contactName;
  String? productCategory;
  String? quoteStatus;
  String? quoteValidity;
  String? expClosureDate;
  dynamic? quoteCommit;
  String? createdBy;
  String? createdFullName;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;
  dynamic? regretBy;
  dynamic? regretOn;
  dynamic? regretReason;
  dynamic? isActive;
  dynamic? installationCharges;
  dynamic? otherCharges;
  String? warrantyPeriod;
  String? deliveryInWeeks;
  dynamic? advancePaymentPer;
  dynamic? advancePaymentAmt;
  String? otherRemarks;
  dynamic? isSpr;
  dynamic? noOfSalesAdvice;
  dynamic? isSalesAdviceCreated;
  String? kindAttention;
  String? quoteStatusWon;
  dynamic? wonBy;
  String? quoteWonName;
  dynamic? wonOn;
  dynamic? lossReason;
  String? rhApprovalEmail;
  String? rhApproval;
  dynamic? rhApprovalOn;
  dynamic? cbhApprovalEmail;
  String? cbhApproval;
  dynamic? cbhApprovalOn;
  dynamic? gmApprovalEmail;
  String? gmApproval;
  dynamic? gmApprovalOn;
  String? frontlinerValue;
  String? branchHeadValue;
  String? zoneHeadValue;
  String? clustureHeadValue;
  String? postCode;
  String? district;
  String? sprNo;
  String? quoteAccepted;
  dynamic? isReadyForApprove;
  dynamic? isReadySendForApproval;
  dynamic? quoteTotalAmount;
  dynamic? quoteGrossAmount;
  dynamic? quoteGstAmount;

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
        this.noOfSalesAdvice,
        this.isSalesAdviceCreated,
        this.kindAttention,
        this.quoteStatusWon,
        this.wonBy,
        this.quoteWonName,
        this.wonOn,
        this.lossReason,
        this.rhApprovalEmail,
        this.rhApproval,
        this.rhApprovalOn,
        this.cbhApprovalEmail,
        this.cbhApproval,
        this.cbhApprovalOn,
        this.gmApprovalEmail,
        this.gmApproval,
        this.gmApprovalOn,
        this.frontlinerValue,
        this.branchHeadValue,
        this.zoneHeadValue,
        this.clustureHeadValue,
        this.postCode,
        this.district,
        this.sprNo,
        this.quoteAccepted,
        this.isReadyForApprove,
        this.isReadySendForApproval,
        this.quoteTotalAmount,
        this.quoteGrossAmount,
        this.quoteGstAmount});

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
    noOfSalesAdvice = json['no_of_sales_advice'];
    isSalesAdviceCreated = json['is_sales_advice_created'];
    kindAttention = json['kind_attention'];
    quoteStatusWon = json['quote_status_won'];
    wonBy = json['won_by'];
    quoteWonName = json['quote_won_name'];
    wonOn = json['won_on'];
    lossReason = json['loss_reason'];
    rhApprovalEmail = json['rh_approval_email'];
    rhApproval = json['rh_approval'];
    rhApprovalOn = json['rh_approval_on'];
    cbhApprovalEmail = json['cbh_approval_email'];
    cbhApproval = json['cbh_approval'];
    cbhApprovalOn = json['cbh_approval_on'];
    gmApprovalEmail = json['gm_approval_email'];
    gmApproval = json['gm_approval'];
    gmApprovalOn = json['gm_approval_on'];
    frontlinerValue = json['frontliner_value'];
    branchHeadValue = json['branch_head_value'];
    zoneHeadValue = json['zone_head_value'];
    clustureHeadValue = json['clusture_head_value'];
    postCode = json['post_code'];
    district = json['district'];
    sprNo = json['spr_no'];
    quoteAccepted = json['quote_accepted'];
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
    data['kind_attention'] = this.kindAttention;
    data['quote_status_won'] = this.quoteStatusWon;
    data['won_by'] = this.wonBy;
    data['quote_won_name'] = this.quoteWonName;
    data['won_on'] = this.wonOn;
    data['loss_reason'] = this.lossReason;
    data['rh_approval_email'] = this.rhApprovalEmail;
    data['rh_approval'] = this.rhApproval;
    data['rh_approval_on'] = this.rhApprovalOn;
    data['cbh_approval_email'] = this.cbhApprovalEmail;
    data['cbh_approval'] = this.cbhApproval;
    data['cbh_approval_on'] = this.cbhApprovalOn;
    data['gm_approval_email'] = this.gmApprovalEmail;
    data['gm_approval'] = this.gmApproval;
    data['gm_approval_on'] = this.gmApprovalOn;
    data['frontliner_value'] = this.frontlinerValue;
    data['branch_head_value'] = this.branchHeadValue;
    data['zone_head_value'] = this.zoneHeadValue;
    data['clusture_head_value'] = this.clustureHeadValue;
    data['post_code'] = this.postCode;
    data['district'] = this.district;
    data['spr_no'] = this.sprNo;
    data['quote_accepted'] = this.quoteAccepted;
    data['is_ready_for_approve'] = this.isReadyForApprove;
    data['is_ready_send_for_approval'] = this.isReadySendForApproval;
    data['quote_total_amount'] = this.quoteTotalAmount;
    data['quote_gross_amount'] = this.quoteGrossAmount;
    data['quote_gst_amount'] = this.quoteGstAmount;
    return data;
  }
}