class RollingForeCastListModal {
  String? condition;
  String? totalRows;
  String? salesForecastId;
  dynamic? lineNo;
  String? salesCycleId;
  String? quoteId;
  int? quoteLineNo;
  String? accountCode;
  String? accountName;
  String? regionName;
  String? clusterName;
  String? createdBy;
  String? createdFullName;
  String? createdOn;
  String? itemCode;
  String? itemName;
  String? itemSpecification;
  String? itemVarient;
  String? itemCategoryCode;
  String? itemParentCategoryCode;
  dynamic? quoteQty;
  double? quoteApprovedAmountPerUnit;
  String? closureMonth;
  String? closureYear;
  String? quoteValidity;
  String? approvedBy;
  String? approvedOn;
  String? estClosureDate;
  dynamic? estBudgetAmount;
  String? requiredRegionName;
  String? requiredClusterName;
  dynamic? qty;

  RollingForeCastListModal(
      {this.condition,
        this.totalRows,
        this.salesForecastId,
        this.lineNo,
        this.salesCycleId,
        this.quoteId,
        this.quoteLineNo,
        this.accountCode,
        this.accountName,
        this.regionName,
        this.clusterName,
        this.createdBy,
        this.createdFullName,
        this.createdOn,
        this.itemCode,
        this.itemName,
        this.itemSpecification,
        this.itemVarient,
        this.itemCategoryCode,
        this.itemParentCategoryCode,
        this.quoteQty,
        this.quoteApprovedAmountPerUnit,
        this.closureMonth,
        this.closureYear,
        this.quoteValidity,
        this.approvedBy,
        this.approvedOn,
        this.estClosureDate,
        this.estBudgetAmount,
        this.requiredRegionName,
        this.requiredClusterName,
        this.qty});

  RollingForeCastListModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    salesForecastId = json['sales_forecast_id'];
    lineNo = json['line_no'];
    salesCycleId = json['sales_cycle_id'];
    quoteId = json['quote_id'];
    quoteLineNo = json['quote_line_no'];
    accountCode = json['account_code'];
    accountName = json['account_name'];
    regionName = json['region_name'];
    clusterName = json['cluster_name'];
    createdBy = json['created_by'];
    createdFullName = json['created_full_name'];
    createdOn = json['created_on'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    itemSpecification = json['item_specification'];
    itemVarient = json['item_varient'];
    itemCategoryCode = json['item_category_code'];
    itemParentCategoryCode = json['item_parent_category_code'];
    quoteQty = json['quote_qty'];
    quoteApprovedAmountPerUnit = json['quote_approved_amount_per_unit'];
    closureMonth = json['closure_month'];
    closureYear = json['closure_year'];
    quoteValidity = json['quote_validity'];
    approvedBy = json['approved_by'];
    approvedOn = json['approved_on'];
    estClosureDate = json['est_closure_date'];
    estBudgetAmount = json['est_budget_amount'];
    requiredRegionName = json['required_region_name'];
    requiredClusterName = json['required_cluster_name'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['sales_forecast_id'] = this.salesForecastId;
    data['line_no'] = this.lineNo;
    data['sales_cycle_id'] = this.salesCycleId;
    data['quote_id'] = this.quoteId;
    data['quote_line_no'] = this.quoteLineNo;
    data['account_code'] = this.accountCode;
    data['account_name'] = this.accountName;
    data['region_name'] = this.regionName;
    data['cluster_name'] = this.clusterName;
    data['created_by'] = this.createdBy;
    data['created_full_name'] = this.createdFullName;
    data['created_on'] = this.createdOn;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['item_specification'] = this.itemSpecification;
    data['item_varient'] = this.itemVarient;
    data['item_category_code'] = this.itemCategoryCode;
    data['item_parent_category_code'] = this.itemParentCategoryCode;
    data['quote_qty'] = this.quoteQty;
    data['quote_approved_amount_per_unit'] = this.quoteApprovedAmountPerUnit;
    data['closure_month'] = this.closureMonth;
    data['closure_year'] = this.closureYear;
    data['quote_validity'] = this.quoteValidity;
    data['approved_by'] = this.approvedBy;
    data['approved_on'] = this.approvedOn;
    data['est_closure_date'] = this.estClosureDate;
    data['est_budget_amount'] = this.estBudgetAmount;
    data['required_region_name'] = this.requiredRegionName;
    data['required_cluster_name'] = this.requiredClusterName;
    data['qty'] = this.qty;
    return data;
  }
}