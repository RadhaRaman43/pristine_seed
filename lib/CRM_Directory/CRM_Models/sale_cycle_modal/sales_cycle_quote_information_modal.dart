class SalesCycleQuoteInformationModal {
  String? condition;
  String? message;
  String? quoteId;
  double? quoteVersion;
  String? salesCycleId;
  String? accountCode;
  String? accountName;
  String? contactCode;
  String? contactName;
  String? productCategory;
  String? productCategoryCode;
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
  String? sprNo;
  int? isReadyForApprove;
  int? isReadySendForApproval;
  double? quoteTotalAmount;
  double? quoteGrossAmount;
  double? quoteGstAmount;
  List<QuoteItems>? quoteItems;
  String? shippingAddress;
  String? shippingAddress2;
  String? shippingPostCode;
  String? shippingStateCode;
  String? shippingStateName;
  String? shippingCity;
  String? shippingDistrict;
  String? shippingPhoneNo;
  String? shippingEmailId;


  SalesCycleQuoteInformationModal(
      {this.condition,
        this.message,
        this.quoteId,
        this.quoteVersion,
        this.salesCycleId,
        this.accountCode,
        this.accountName,
        this.contactCode,
        this.contactName,
        this.productCategory,
        this.productCategoryCode,
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
        this.sprNo,
        this.isReadyForApprove,
        this.isReadySendForApproval,
        this.quoteTotalAmount,
        this.quoteGrossAmount,
        this.quoteGstAmount,
        this.quoteItems,
        this.shippingAddress,
        this.shippingAddress2,
        this.shippingPostCode,
        this.shippingStateCode,
        this.shippingStateName,
        this.shippingCity,
        this.shippingDistrict,
        this.shippingPhoneNo,
        this.shippingEmailId});

  SalesCycleQuoteInformationModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    quoteId = json['quote_id'];
    quoteVersion = json['quote_version'];
    salesCycleId = json['sales_cycle_id'];
    accountCode = json['account_code'];
    accountName = json['account_name'];
    contactCode = json['contact_code'];
    contactName = json['contact_name'];
    productCategory = json['product_category'];
    productCategoryCode = json['product_category_code'];
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
    sprNo = json['spr_no'];
    isReadyForApprove = json['is_ready_for_approve'];
    isReadySendForApproval = json['is_ready_send_for_approval'];
    quoteTotalAmount = json['quote_total_amount'];
    quoteGrossAmount = json['quote_gross_amount'];
    quoteGstAmount = json['quote_gst_amount'];
    if (json['quote_items'] != null) {
      quoteItems = <QuoteItems>[];
      json['quote_items'].forEach((v) {
        quoteItems!.add(new QuoteItems.fromJson(v));
      });
    }
    shippingAddress = json['shipping_address'];
    shippingAddress2 = json['shipping_address2'];
    shippingPostCode = json['shipping_post_code'];
    shippingStateCode = json['shipping_state_code'];
    shippingStateName = json['shipping_state_name'];
    shippingCity = json['shipping_city'];
    shippingDistrict = json['shipping_district'];
    shippingPhoneNo = json['shipping_phone_no'];
    shippingEmailId = json['shipping_email_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['quote_id'] = this.quoteId;
    data['quote_version'] = this.quoteVersion;
    data['sales_cycle_id'] = this.salesCycleId;
    data['account_code'] = this.accountCode;
    data['account_name'] = this.accountName;
    data['contact_code'] = this.contactCode;
    data['contact_name'] = this.contactName;
    data['product_category'] = this.productCategory;
    data['product_category_code'] = this.productCategoryCode;
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
    data['spr_no'] = this.sprNo;
    data['is_ready_for_approve'] = this.isReadyForApprove;
    data['is_ready_send_for_approval'] = this.isReadySendForApproval;
    data['quote_total_amount'] = this.quoteTotalAmount;
    data['quote_gross_amount'] = this.quoteGrossAmount;
    data['quote_gst_amount'] = this.quoteGstAmount;
    if (this.quoteItems != null) {
      data['quote_items'] = this.quoteItems!.map((v) => v.toJson()).toList();
    }
    data['shipping_address'] = this.shippingAddress;
    data['shipping_address2'] = this.shippingAddress2;
    data['shipping_post_code'] = this.shippingPostCode;
    data['shipping_state_code'] = this.shippingStateCode;
    data['shipping_state_name'] = this.shippingStateName;
    data['shipping_city'] = this.shippingCity;
    data['shipping_district'] = this.shippingDistrict;
    data['shipping_phone_no'] = this.shippingPhoneNo;
    data['shipping_email_id'] = this.shippingEmailId;
    return data;
  }
}

class QuoteItems {
  String? quoteId;
  int? srNo;
  int? lineNo;
  String? salesCycleId;
  String? itemCode;
  String? itemName;
  String? itemDescription;
  double? qty;
  double? unitPrice;
  double? mrpPrice;
  double? quoteLinePrice;
  double? totalPrice;
  double? discountPer;
  double? discountAmt;
  int? isSprRequired;
  String? sprNo;
  double? sgstPer;
  double? cgstPer;
  double? igstPer;
  double? sgstAmt;
  double? cgstAmt;
  double? igstAmt;
  double? gstAmount;
  double? grossAmount;
  String? createdBy;
  String? createdOn;
  String? lineStatus;
  String? updatedBy;
  String? updatedOn;
  String? regretBy;
  String? regretOn;
  String? regretReason;
  double? standardCost;
  double? branchTransferPrice;
  double? minimalAcceptablePrice;
  double? listSellingPrice;
  String? categoryCode;
  String? categoryName;
  String? warrantyPeriod;
  String? deliveryInWeeks;

  QuoteItems(
      {this.quoteId,
        this.srNo,
        this.lineNo,
        this.salesCycleId,
        this.itemCode,
        this.itemName,
        this.itemDescription,
        this.qty,
        this.unitPrice,
        this.mrpPrice,
        this.quoteLinePrice,
        this.totalPrice,
        this.discountPer,
        this.discountAmt,
        this.isSprRequired,
        this.sprNo,
        this.sgstPer,
        this.cgstPer,
        this.igstPer,
        this.sgstAmt,
        this.cgstAmt,
        this.igstAmt,
        this.gstAmount,
        this.grossAmount,
        this.createdBy,
        this.createdOn,
        this.lineStatus,
        this.updatedBy,
        this.updatedOn,
        this.regretBy,
        this.regretOn,
        this.regretReason,
        this.standardCost,
        this.branchTransferPrice,
        this.minimalAcceptablePrice,
        this.listSellingPrice,
        this.categoryCode,
        this.categoryName,
        this.warrantyPeriod,
        this.deliveryInWeeks});

  QuoteItems.fromJson(Map<String, dynamic> json) {
    quoteId = json['quote_id'];
    srNo = json['sr_no'];
    lineNo = json['line_no'];
    salesCycleId = json['sales_cycle_id'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    itemDescription = json['item_description'];
    qty = json['qty'];
    unitPrice = json['unit_price'];
    mrpPrice = json['mrp_price'];
    quoteLinePrice = json['quote_line_price'];
    totalPrice = json['total_price'];
    discountPer = json['discount_per'];
    discountAmt = json['discount_amt'];
    isSprRequired = json['is_spr_required'];
    sprNo = json['spr_no'];
    sgstPer = json['sgst_per'];
    cgstPer = json['cgst_per'];
    igstPer = json['igst_per'];
    sgstAmt = json['sgst_amt'];
    cgstAmt = json['cgst_amt'];
    igstAmt = json['igst_amt'];
    gstAmount = json['gst_amount'];
    grossAmount = json['gross_amount'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    lineStatus = json['line_status'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
    regretBy = json['regret_by'];
    regretOn = json['regret_on'];
    regretReason = json['regret_reason'];
    standardCost = json['standard_cost'];
    branchTransferPrice = json['branch_transfer_price'];
    minimalAcceptablePrice = json['minimal_acceptable_price'];
    listSellingPrice = json['list_selling_price'];
    categoryCode = json['category_code'];
    categoryName = json['category_name'];
    warrantyPeriod = json['warranty_period'];
    deliveryInWeeks = json['delivery_in_weeks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quote_id'] = this.quoteId;
    data['sr_no'] = this.srNo;
    data['line_no'] = this.lineNo;
    data['sales_cycle_id'] = this.salesCycleId;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['item_description'] = this.itemDescription;
    data['qty'] = this.qty;
    data['unit_price'] = this.unitPrice;
    data['mrp_price'] = this.mrpPrice;
    data['quote_line_price'] = this.quoteLinePrice;
    data['total_price'] = this.totalPrice;
    data['discount_per'] = this.discountPer;
    data['discount_amt'] = this.discountAmt;
    data['is_spr_required'] = this.isSprRequired;
    data['spr_no'] = this.sprNo;
    data['sgst_per'] = this.sgstPer;
    data['cgst_per'] = this.cgstPer;
    data['igst_per'] = this.igstPer;
    data['sgst_amt'] = this.sgstAmt;
    data['cgst_amt'] = this.cgstAmt;
    data['igst_amt'] = this.igstAmt;
    data['gst_amount'] = this.gstAmount;
    data['gross_amount'] = this.grossAmount;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['line_status'] = this.lineStatus;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    data['regret_by'] = this.regretBy;
    data['regret_on'] = this.regretOn;
    data['regret_reason'] = this.regretReason;
    data['standard_cost'] = this.standardCost;
    data['branch_transfer_price'] = this.branchTransferPrice;
    data['minimal_acceptable_price'] = this.minimalAcceptablePrice;
    data['list_selling_price'] = this.listSellingPrice;
    data['category_code'] = this.categoryCode;
    data['category_name'] = this.categoryName;
    data['warranty_period'] = this.warrantyPeriod;
    data['delivery_in_weeks'] = this.deliveryInWeeks;
    return data;
  }
}