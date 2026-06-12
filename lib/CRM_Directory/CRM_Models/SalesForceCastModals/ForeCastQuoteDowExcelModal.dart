class ForeCastQuoteDowExcelModal {
  String? condition;
  int? lineNo;
  String? salesCycleId;
  String? quoteId;
  int? quoteLineNo;
  String? itemCode;
  String? itemName;
  String? itemCategoryCode;
  String? itemParentCategoryCode;
  dynamic? quoteQty;
  dynamic? quoteApprovedAmountPerUnit;
  String? closureMonth;
  String? closureYear;
  String? itemVarient;
  String? requiredRegionName;
  String? requiredClusterName;
  dynamic? qty;

  ForeCastQuoteDowExcelModal(
      {this.condition,
        this.lineNo,
        this.salesCycleId,
        this.quoteId,
        this.quoteLineNo,
        this.itemCode,
        this.itemName,
        this.itemCategoryCode,
        this.itemParentCategoryCode,
        this.quoteQty,
        this.quoteApprovedAmountPerUnit,
        this.closureMonth,
        this.closureYear,
        this.itemVarient,
        this.requiredRegionName,
        this.requiredClusterName,
        this.qty});

  ForeCastQuoteDowExcelModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    lineNo = json['line_no'];
    salesCycleId = json['sales_cycle_id'];
    quoteId = json['quote_id'];
    quoteLineNo = json['quote_line_no'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    itemCategoryCode = json['item_category_code'];
    itemParentCategoryCode = json['item_parent_category_code'];
    quoteQty = json['quote_qty'];
    quoteApprovedAmountPerUnit = json['quote_approved_amount_per_unit'];
    closureMonth = json['closure_month'];
    closureYear = json['closure_year'];
    itemVarient = json['item_varient'];
    requiredRegionName = json['required_region_name'];
    requiredClusterName = json['required_cluster_name'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['line_no'] = this.lineNo;
    data['sales_cycle_id'] = this.salesCycleId;
    data['quote_id'] = this.quoteId;
    data['quote_line_no'] = this.quoteLineNo;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['item_category_code'] = this.itemCategoryCode;
    data['item_parent_category_code'] = this.itemParentCategoryCode;
    data['quote_qty'] = this.quoteQty;
    data['quote_approved_amount_per_unit'] = this.quoteApprovedAmountPerUnit;
    data['closure_month'] = this.closureMonth;
    data['closure_year'] = this.closureYear;
    data['item_varient'] = this.itemVarient;
    data['required_region_name'] = this.requiredRegionName;
    data['required_cluster_name'] = this.requiredClusterName;
    data['qty'] = this.qty;
    return data;
  }
}