class SaleCycleCompetitorProductInformationModal {
  String? condition;
  String? message;
  String? totalRows;
  String? quoteId;
  String? salesCycleId;
  dynamic? lineNo;
  String? accountCode;
  String? accountName;
  String? productCategory;
  String? parentProductCategory;
  String? createdBy;
  String? createdFullName;
  String? createdOn;
  String? updatedBy;
  String? itemCode;
  String? itemDescription;
  dynamic? qty;
  dynamic? unitPrice;
  dynamic? mrpPrice;
  dynamic? totalPrice;
  dynamic? methodexPrice;
  String? competitorName;
  dynamic? competitorPrice;
  String? lossReason;
  String? lossBy;
  String? lossOn;
  String? lineStatus;
  String? actualSalesCycleApprovalStatus;
  String? salesCycleStatus;
  String? salesCycleApprovalStatus;
  dynamic? approvedAmount;
  dynamic? approvedAmountPerUnit;
  String? quoteAccepted;
  String? estClosureDate;
  String? frontlinerValue;
  String? branchHeadValue;
  String? zoneHeadValue;
  String? clustureHeadValue;
  String? companyProfileType;
  String? postCode;
  String? district;

  SaleCycleCompetitorProductInformationModal(
      {this.condition,
        this.message,
        this.totalRows,
        this.quoteId,
        this.salesCycleId,
        this.lineNo,
        this.accountCode,
        this.accountName,
        this.productCategory,
        this.parentProductCategory,
        this.createdBy,
        this.createdFullName,
        this.createdOn,
        this.updatedBy,
        this.itemCode,
        this.itemDescription,
        this.qty,
        this.unitPrice,
        this.mrpPrice,
        this.totalPrice,
        this.methodexPrice,
        this.competitorName,
        this.competitorPrice,
        this.lossReason,
        this.lossBy,
        this.lossOn,
        this.lineStatus,
        this.actualSalesCycleApprovalStatus,
        this.salesCycleStatus,
        this.salesCycleApprovalStatus,
        this.approvedAmount,
        this.approvedAmountPerUnit,
        this.quoteAccepted,
        this.estClosureDate,
        this.frontlinerValue,
        this.branchHeadValue,
        this.zoneHeadValue,
        this.clustureHeadValue,
        this.companyProfileType,
        this.postCode,
        this.district});

  SaleCycleCompetitorProductInformationModal.fromJson(
      Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    totalRows = json['total_rows'];
    quoteId = json['quote_id'];
    salesCycleId = json['sales_cycle_id'];
    lineNo = json['line_no'];
    accountCode = json['account_code'];
    accountName = json['account_name'];
    productCategory = json['product_category'];
    parentProductCategory = json['parent_product_category'];
    createdBy = json['created_by'];
    createdFullName = json['created_full_name'];
    createdOn = json['created_on'];
    updatedBy = json['updated_by'];
    itemCode = json['item_code'];
    itemDescription = json['item_description'];
    qty = json['qty'];
    unitPrice = json['unit_price'];
    mrpPrice = json['mrp_price'];
    totalPrice = json['total_price'];
    methodexPrice = json['methodex_price'];
    competitorName = json['competitor_name'];
    competitorPrice = json['competitor_price'];
    lossReason = json['loss_reason'];
    lossBy = json['loss_by'];
    lossOn = json['loss_on'];
    lineStatus = json['line_status'];
    actualSalesCycleApprovalStatus = json['actual_sales_cycle_approval_status'];
    salesCycleStatus = json['sales_cycle_status'];
    salesCycleApprovalStatus = json['sales_cycle_approval_status'];
    approvedAmount = json['approved_amount'];
    approvedAmountPerUnit = json['approved_amount_per_unit'];
    quoteAccepted = json['quote_accepted'];
    estClosureDate = json['est_closure_date'];
    frontlinerValue = json['frontliner_value'];
    branchHeadValue = json['branch_head_value'];
    zoneHeadValue = json['zone_head_value'];
    clustureHeadValue = json['clusture_head_value'];
    companyProfileType = json['company_profile_type'];
    postCode = json['post_code'];
    district = json['district'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['total_rows'] = this.totalRows;
    data['quote_id'] = this.quoteId;
    data['sales_cycle_id'] = this.salesCycleId;
    data['line_no'] = this.lineNo;
    data['account_code'] = this.accountCode;
    data['account_name'] = this.accountName;
    data['product_category'] = this.productCategory;
    data['parent_product_category'] = this.parentProductCategory;
    data['created_by'] = this.createdBy;
    data['created_full_name'] = this.createdFullName;
    data['created_on'] = this.createdOn;
    data['updated_by'] = this.updatedBy;
    data['item_code'] = this.itemCode;
    data['item_description'] = this.itemDescription;
    data['qty'] = this.qty;
    data['unit_price'] = this.unitPrice;
    data['mrp_price'] = this.mrpPrice;
    data['total_price'] = this.totalPrice;
    data['methodex_price'] = this.methodexPrice;
    data['competitor_name'] = this.competitorName;
    data['competitor_price'] = this.competitorPrice;
    data['loss_reason'] = this.lossReason;
    data['loss_by'] = this.lossBy;
    data['loss_on'] = this.lossOn;
    data['line_status'] = this.lineStatus;
    data['actual_sales_cycle_approval_status'] =
        this.actualSalesCycleApprovalStatus;
    data['sales_cycle_status'] = this.salesCycleStatus;
    data['sales_cycle_approval_status'] = this.salesCycleApprovalStatus;
    data['approved_amount'] = this.approvedAmount;
    data['approved_amount_per_unit'] = this.approvedAmountPerUnit;
    data['quote_accepted'] = this.quoteAccepted;
    data['est_closure_date'] = this.estClosureDate;
    data['frontliner_value'] = this.frontlinerValue;
    data['branch_head_value'] = this.branchHeadValue;
    data['zone_head_value'] = this.zoneHeadValue;
    data['clusture_head_value'] = this.clustureHeadValue;
    data['company_profile_type'] = this.companyProfileType;
    data['post_code'] = this.postCode;
    data['district'] = this.district;
    return data;
  }
}