class ItemMasterBySalesId_Model {
  String? condition;
  String? message;
  String? totalRows;
  String? itemCode;
  String? name;
  String? displayName;
  String? description;
  String? categoryCode;
  String? productGroup;
  String? subProductGroup;
  String? subSubProductGroup;
  String? colorCode;
  String? sizeCode;
  String? styleCode;
  String? brandCode;
  String? thiknessGsm;
  String? cubicCapacity;
  String? manufacturerCode;
  String? baseUnitOfMeasure;
  String? purchaseUnitOfMeasure;
  String? saleUnitOfMeasure;
  double? costPerUnit;
  double? mrp;
  double? transferCost;
  double? rsp;
  double? standardCost;
  double? branchTransferPrice;
  double? minimalAcceptablePrice;
  double? listSellingPrice;
  double? weightInKg;
  String? eanCode;
  String? gstGroupCode;
  String? hsnCode;
  int? active;
  int? isExpiryMandatory;
  String? componentType;
  double? length;
  double? width;
  double? height;
  int? isBulky;
  String? updatedOn;
  String? itemLabel;
  int? moq;
  String? salesCycleId;
  int? lineNo;
  int? isSelected;
  String? categoryName;

  ItemMasterBySalesId_Model(
      {this.condition,
        this.message,
        this.totalRows,
        this.itemCode,
        this.name,
        this.displayName,
        this.description,
        this.categoryCode,
        this.productGroup,
        this.subProductGroup,
        this.subSubProductGroup,
        this.colorCode,
        this.sizeCode,
        this.styleCode,
        this.brandCode,
        this.thiknessGsm,
        this.cubicCapacity,
        this.manufacturerCode,
        this.baseUnitOfMeasure,
        this.purchaseUnitOfMeasure,
        this.saleUnitOfMeasure,
        this.costPerUnit,
        this.mrp,
        this.transferCost,
        this.rsp,
        this.standardCost,
        this.branchTransferPrice,
        this.minimalAcceptablePrice,
        this.listSellingPrice,
        this.weightInKg,
        this.eanCode,
        this.gstGroupCode,
        this.hsnCode,
        this.active,
        this.isExpiryMandatory,
        this.componentType,
        this.length,
        this.width,
        this.height,
        this.isBulky,
        this.updatedOn,
        this.itemLabel,
        this.moq,
        this.salesCycleId,
        this.lineNo,
        this.isSelected,
        this.categoryName});

  ItemMasterBySalesId_Model.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    totalRows = json['total_rows'];
    itemCode = json['item_code'];
    name = json['name'];
    displayName = json['display_name'];
    description = json['description'];
    categoryCode = json['category_code'];
    productGroup = json['product_group'];
    subProductGroup = json['sub_product_group'];
    subSubProductGroup = json['sub_sub_product_group'];
    colorCode = json['color_code'];
    sizeCode = json['size_code'];
    styleCode = json['style_code'];
    brandCode = json['brand_code'];
    thiknessGsm = json['thikness_gsm'];
    cubicCapacity = json['cubic_capacity'];
    manufacturerCode = json['manufacturer_code'];
    baseUnitOfMeasure = json['base_unit_of_measure'];
    purchaseUnitOfMeasure = json['purchase_unit_of_measure'];
    saleUnitOfMeasure = json['sale_unit_of_measure'];
    costPerUnit = json['cost_per_unit'];
    mrp = json['mrp'];
    transferCost = json['transfer_cost'];
    rsp = json['rsp'];
    standardCost = json['standard_cost'];
    branchTransferPrice = json['branch_transfer_price'];
    minimalAcceptablePrice = json['minimal_acceptable_price'];
    listSellingPrice = json['list_selling_price'];
    weightInKg = json['weight_in_kg'];
    eanCode = json['ean_code'];
    gstGroupCode = json['gst_group_code'];
    hsnCode = json['hsn_code'];
    active = json['active'];
    isExpiryMandatory = json['is_expiry_mandatory'];
    componentType = json['component_type'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    isBulky = json['is_bulky'];
    updatedOn = json['updated_on'];
    itemLabel = json['item_label'];
    moq = json['moq'];
    salesCycleId = json['sales_cycle_id'];
    lineNo = json['line_no'];
    isSelected = json['is_selected'];
    categoryName = json['category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['total_rows'] = this.totalRows;
    data['item_code'] = this.itemCode;
    data['name'] = this.name;
    data['display_name'] = this.displayName;
    data['description'] = this.description;
    data['category_code'] = this.categoryCode;
    data['product_group'] = this.productGroup;
    data['sub_product_group'] = this.subProductGroup;
    data['sub_sub_product_group'] = this.subSubProductGroup;
    data['color_code'] = this.colorCode;
    data['size_code'] = this.sizeCode;
    data['style_code'] = this.styleCode;
    data['brand_code'] = this.brandCode;
    data['thikness_gsm'] = this.thiknessGsm;
    data['cubic_capacity'] = this.cubicCapacity;
    data['manufacturer_code'] = this.manufacturerCode;
    data['base_unit_of_measure'] = this.baseUnitOfMeasure;
    data['purchase_unit_of_measure'] = this.purchaseUnitOfMeasure;
    data['sale_unit_of_measure'] = this.saleUnitOfMeasure;
    data['cost_per_unit'] = this.costPerUnit;
    data['mrp'] = this.mrp;
    data['transfer_cost'] = this.transferCost;
    data['rsp'] = this.rsp;
    data['standard_cost'] = this.standardCost;
    data['branch_transfer_price'] = this.branchTransferPrice;
    data['minimal_acceptable_price'] = this.minimalAcceptablePrice;
    data['list_selling_price'] = this.listSellingPrice;
    data['weight_in_kg'] = this.weightInKg;
    data['ean_code'] = this.eanCode;
    data['gst_group_code'] = this.gstGroupCode;
    data['hsn_code'] = this.hsnCode;
    data['active'] = this.active;
    data['is_expiry_mandatory'] = this.isExpiryMandatory;
    data['component_type'] = this.componentType;
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    data['is_bulky'] = this.isBulky;
    data['updated_on'] = this.updatedOn;
    data['item_label'] = this.itemLabel;
    data['moq'] = this.moq;
    data['sales_cycle_id'] = this.salesCycleId;
    data['line_no'] = this.lineNo;
    data['is_selected'] = this.isSelected;
    data['category_name'] = this.categoryName;
    return data;
  }
}