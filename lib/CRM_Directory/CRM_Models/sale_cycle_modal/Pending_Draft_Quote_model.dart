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
  dynamic? quoteCommit;
  String? approvedBy;
  String? approvedFullName;
  dynamic? approvedOn;
  String? rejectReason;
  String? createdBy;
  String? createdFullName;
  String? createdOn;
  String? ownerFullName;
  String? updatedBy;
  String? updatedFullName;
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
  String? quoteStatusWon;
  dynamic? wonBy;
  String? quoteWonName;
  dynamic? wonOn;
  dynamic? lossReason;
  String? quoteAccepted;
  dynamic? expectedRevenue;
  String? rhApprovalEmail;
  String? rhApproval;
  dynamic? rhApprovalOn;
  dynamic? cbhApprovalEmail;
  String? cbhApproval;
  dynamic? cbhApprovalOn;
  String? gmApprovalEmail;
  String? gmApproval;
  dynamic? gmApprovalOn;
  dynamic? frontlinerValue;
  String? branchHeadValue;
  dynamic? zoneHeadValue;
  String? clustureHeadValue;
  String? postCode;
  String? district;
  String? sprNo;
  dynamic? isReadyForApprove;
  dynamic? isReadySendForApproval;
  dynamic? quoteTotalAmount;
  double? quoteGrossAmount;
  double? quoteGstAmount;
  String? itemCode;
  String? itemName;
  String? itemDescription;
  String? productName;
  String? productDescription;
  dynamic? qty;
  dynamic? unitPrice;
  dynamic? mrpPrice;
  dynamic? quoteLinePrice;
  dynamic? totalPrice;
  dynamic? discountPer;
  dynamic? discountAmt;
  dynamic? discountAmtPerUnit;
  double? bmDiscountPer;
  double? gmDiscountPer;
  dynamic? gmDiscountAmount;
  dynamic? gmTotalDiscountAmount;
  dynamic? approvedDiscountPer;
  dynamic? approvedAmount;
  dynamic? approvedAmountPerUnit;
  dynamic? standardCost;
  dynamic? branchTransferPrice;
  dynamic? minimalAcceptablePrice;
  dynamic? listSellingPrice;
  dynamic? isSprRequired;
  dynamic? sgstPer;
  dynamic? cgstPer;
  dynamic? igstPer;
  double? sgstAmt;
  double? cgstAmt;
  dynamic? igstAmt;
  double? gstAmount;
  double? grossAmount;
  dynamic? salesCredit;
  String? lineStatus;
  String? itemCategoryName;

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
        this.ownerFullName,
        this.updatedBy,
        this.updatedFullName,
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
        this.quoteStatusWon,
        this.wonBy,
        this.quoteWonName,
        this.wonOn,
        this.lossReason,
        this.quoteAccepted,
        this.expectedRevenue,
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
        this.isReadyForApprove,
        this.isReadySendForApproval,
        this.quoteTotalAmount,
        this.quoteGrossAmount,
        this.quoteGstAmount,
        this.itemCode,
        this.itemName,
        this.itemDescription,
        this.productName,
        this.productDescription,
        this.qty,
        this.unitPrice,
        this.mrpPrice,
        this.quoteLinePrice,
        this.totalPrice,
        this.discountPer,
        this.discountAmt,
        this.discountAmtPerUnit,
        this.bmDiscountPer,
        this.gmDiscountPer,
        this.gmDiscountAmount,
        this.gmTotalDiscountAmount,
        this.approvedDiscountPer,
        this.approvedAmount,
        this.approvedAmountPerUnit,
        this.standardCost,
        this.branchTransferPrice,
        this.minimalAcceptablePrice,
        this.listSellingPrice,
        this.isSprRequired,
        this.sgstPer,
        this.cgstPer,
        this.igstPer,
        this.sgstAmt,
        this.cgstAmt,
        this.igstAmt,
        this.gstAmount,
        this.grossAmount,
        this.salesCredit,
        this.lineStatus,
        this.itemCategoryName});

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
    ownerFullName = json['owner_full_name'];
    updatedBy = json['updated_by'];
    updatedFullName = json['updated_full_name'];
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
    quoteStatusWon = json['quote_status_won'];
    wonBy = json['won_by'];
    quoteWonName = json['quote_won_name'];
    wonOn = json['won_on'];
    lossReason = json['loss_reason'];
    quoteAccepted = json['quote_accepted'];
    expectedRevenue = json['expected_revenue'];
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
    isReadyForApprove = json['is_ready_for_approve'];
    isReadySendForApproval = json['is_ready_send_for_approval'];
    quoteTotalAmount = json['quote_total_amount'];
    quoteGrossAmount = json['quote_gross_amount'];
    quoteGstAmount = json['quote_gst_amount'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    itemDescription = json['item_description'];
    productName = json['product_name'];
    productDescription = json['product_description'];
    qty = json['qty'];
    unitPrice = json['unit_price'];
    mrpPrice = json['mrp_price'];
    quoteLinePrice = json['quote_line_price'];
    totalPrice = json['total_price'];
    discountPer = json['discount_per'];
    discountAmt = json['discount_amt'];
    discountAmtPerUnit = json['discount_amt_per_unit'];
    bmDiscountPer = json['bm_discount_per'];
    gmDiscountPer = json['gm_discount_per'];
    gmDiscountAmount = json['gm_discount_amount'];
    gmTotalDiscountAmount = json['gm_total_discount_amount'];
    approvedDiscountPer = json['approved_discount_per'];
    approvedAmount = json['approved_amount'];
    approvedAmountPerUnit = json['approved_amount_per_unit'];
    standardCost = json['standard_cost'];
    branchTransferPrice = json['branch_transfer_price'];
    minimalAcceptablePrice = json['minimal_acceptable_price'];
    listSellingPrice = json['list_selling_price'];
    isSprRequired = json['is_spr_required'];
    sgstPer = json['sgst_per'];
    cgstPer = json['cgst_per'];
    igstPer = json['igst_per'];
    sgstAmt = json['sgst_amt'];
    cgstAmt = json['cgst_amt'];
    igstAmt = json['igst_amt'];
    gstAmount = json['gst_amount'];
    grossAmount = json['gross_amount'];
    salesCredit = json['sales_credit'];
    lineStatus = json['line_status'];
    itemCategoryName = json['item_category_name'];
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
    data['owner_full_name'] = this.ownerFullName;
    data['updated_by'] = this.updatedBy;
    data['updated_full_name'] = this.updatedFullName;
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
    data['quote_status_won'] = this.quoteStatusWon;
    data['won_by'] = this.wonBy;
    data['quote_won_name'] = this.quoteWonName;
    data['won_on'] = this.wonOn;
    data['loss_reason'] = this.lossReason;
    data['quote_accepted'] = this.quoteAccepted;
    data['expected_revenue'] = this.expectedRevenue;
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
    data['is_ready_for_approve'] = this.isReadyForApprove;
    data['is_ready_send_for_approval'] = this.isReadySendForApproval;
    data['quote_total_amount'] = this.quoteTotalAmount;
    data['quote_gross_amount'] = this.quoteGrossAmount;
    data['quote_gst_amount'] = this.quoteGstAmount;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['item_description'] = this.itemDescription;
    data['product_name'] = this.productName;
    data['product_description'] = this.productDescription;
    data['qty'] = this.qty;
    data['unit_price'] = this.unitPrice;
    data['mrp_price'] = this.mrpPrice;
    data['quote_line_price'] = this.quoteLinePrice;
    data['total_price'] = this.totalPrice;
    data['discount_per'] = this.discountPer;
    data['discount_amt'] = this.discountAmt;
    data['discount_amt_per_unit'] = this.discountAmtPerUnit;
    data['bm_discount_per'] = this.bmDiscountPer;
    data['gm_discount_per'] = this.gmDiscountPer;
    data['gm_discount_amount'] = this.gmDiscountAmount;
    data['gm_total_discount_amount'] = this.gmTotalDiscountAmount;
    data['approved_discount_per'] = this.approvedDiscountPer;
    data['approved_amount'] = this.approvedAmount;
    data['approved_amount_per_unit'] = this.approvedAmountPerUnit;
    data['standard_cost'] = this.standardCost;
    data['branch_transfer_price'] = this.branchTransferPrice;
    data['minimal_acceptable_price'] = this.minimalAcceptablePrice;
    data['list_selling_price'] = this.listSellingPrice;
    data['is_spr_required'] = this.isSprRequired;
    data['sgst_per'] = this.sgstPer;
    data['cgst_per'] = this.cgstPer;
    data['igst_per'] = this.igstPer;
    data['sgst_amt'] = this.sgstAmt;
    data['cgst_amt'] = this.cgstAmt;
    data['igst_amt'] = this.igstAmt;
    data['gst_amount'] = this.gstAmount;
    data['gross_amount'] = this.grossAmount;
    data['sales_credit'] = this.salesCredit;
    data['line_status'] = this.lineStatus;
    data['item_category_name'] = this.itemCategoryName;
    return data;
  }
}