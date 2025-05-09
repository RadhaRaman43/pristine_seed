class SalesCycleByIdModel {
  String? condition;
  String? totalRows;
  int? srNo;
  int? lineNo;
  String? salesCycleId;
  String? itemCode;
  String? itemName;
  String? itemDescription;
  double? qty;
  double? unitPrice;
  double? mrpPrice;
  double? totalPrice;
  String? createdBy;
  String? createdOn;
  String? lineStatus;
  String? updatedBy;
  String? updatedOn;
  String? competitorName;
  double? competitorPrice;
  String? lossReason;
  String? lossBy;
  String? lossOn;
  String? categoryCode;
  String? categoryName;

  SalesCycleByIdModel(
      {this.condition,
        this.totalRows,
        this.srNo,
        this.lineNo,
        this.salesCycleId,
        this.itemCode,
        this.itemName,
        this.itemDescription,
        this.qty,
        this.unitPrice,
        this.mrpPrice,
        this.totalPrice,
        this.createdBy,
        this.createdOn,
        this.lineStatus,
        this.updatedBy,
        this.updatedOn,
        this.competitorName,
        this.competitorPrice,
        this.lossReason,
        this.lossBy,
        this.lossOn,
        this.categoryCode,
        this.categoryName});

  SalesCycleByIdModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    srNo = json['sr_no'];
    lineNo = json['line_no'];
    salesCycleId = json['sales_cycle_id'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    itemDescription = json['item_description'];
    qty = json['qty'];
    unitPrice = json['unit_price'];
    mrpPrice = json['mrp_price'];
    totalPrice = json['total_price'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    lineStatus = json['line_status'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
    competitorName = json['competitor_name'];
    competitorPrice = json['competitor_price'];
    lossReason = json['loss_reason'];
    lossBy = json['loss_by'];
    lossOn = json['loss_on'];
    categoryCode = json['category_code'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['condition'] = this.condition;
    data['sr_no'] = this.srNo;
    data['line_no'] = this.lineNo;
    data['sales_cycle_id'] = this.salesCycleId;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['item_description'] = this.itemDescription;
    data['qty'] = this.qty;
    data['unit_price'] = this.unitPrice;
    data['mrp_price'] = this.mrpPrice;
    data['total_price'] = this.totalPrice;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['line_status'] = this.lineStatus;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    data['competitor_name'] = this.competitorName;
    data['competitor_price'] = this.competitorPrice;
    data['loss_reason'] = this.lossReason;
    data['loss_by'] = this.lossBy;
    data['loss_on'] = this.lossOn;
    data['category_code'] = this.categoryCode;
    data['category_name'] = this.categoryName;
    return data;
  }
}