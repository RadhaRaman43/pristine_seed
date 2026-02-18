class NonStandardItemDataModal {
  String? condition;
  String? message;
  String? totalRows;
  String? salesCycleId;
  String? accountCode;
  String? itemCode;
  String? name;
  String? productType;
  String? categoryCode;
  dynamic? listSellingPrice;
  dynamic? branchTransferPrice;
  double? minimalAcceptablePrice;
  double? standardCost;
  String? gstGroupCode;
  String? hsnCode;
  dynamic? specification;
  dynamic? rateContractValidDate;
  String? componentType;
  dynamic? expiredOn;
  String? updatedOn;
  int? active;
  String? categoryName;

  NonStandardItemDataModal(
      {this.condition,
        this.message,
        this.totalRows,
        this.salesCycleId,
        this.accountCode,
        this.itemCode,
        this.name,
        this.productType,
        this.categoryCode,
        this.listSellingPrice,
        this.branchTransferPrice,
        this.minimalAcceptablePrice,
        this.standardCost,
        this.gstGroupCode,
        this.hsnCode,
        this.specification,
        this.rateContractValidDate,
        this.componentType,
        this.expiredOn,
        this.updatedOn,
        this.active,
        this.categoryName});

  NonStandardItemDataModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    totalRows = json['total_rows'];
    salesCycleId = json['sales_cycle_id'];
    accountCode = json['account_code'];
    itemCode = json['item_code'];
    name = json['name'];
    productType = json['product_type'];
    categoryCode = json['category_code'];
    listSellingPrice = json['list_selling_price'];
    branchTransferPrice = json['branch_transfer_price'];
    minimalAcceptablePrice = json['minimal_acceptable_price'];
    standardCost = json['standard_cost'];
    gstGroupCode = json['gst_group_code'];
    hsnCode = json['hsn_code'];
    specification = json['specification'];
    rateContractValidDate = json['rate_contract_valid_date'];
    componentType = json['component_type'];
    expiredOn = json['expired_on'];
    updatedOn = json['updated_on'];
    active = json['active'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['total_rows'] = this.totalRows;
    data['sales_cycle_id'] = this.salesCycleId;
    data['account_code'] = this.accountCode;
    data['item_code'] = this.itemCode;
    data['name'] = this.name;
    data['product_type'] = this.productType;
    data['category_code'] = this.categoryCode;
    data['list_selling_price'] = this.listSellingPrice;
    data['branch_transfer_price'] = this.branchTransferPrice;
    data['minimal_acceptable_price'] = this.minimalAcceptablePrice;
    data['standard_cost'] = this.standardCost;
    data['gst_group_code'] = this.gstGroupCode;
    data['hsn_code'] = this.hsnCode;
    data['specification'] = this.specification;
    data['rate_contract_valid_date'] = this.rateContractValidDate;
    data['component_type'] = this.componentType;
    data['expired_on'] = this.expiredOn;
    data['updated_on'] = this.updatedOn;
    data['active'] = this.active;
    data['category_name'] = this.categoryName;
    return data;
  }
}
