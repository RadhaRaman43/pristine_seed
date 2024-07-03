class OrderItemGetModel {
  String? condition;
  String? categoryCode;
  String? productGroup;
  String? itemNo;
  String? itemName;
  String? baseUnitOfMeasure;
  double? unitPrice;
  String? imageUrl;
  int? orderQty;
  int? categoryWiseTotalQty;

  OrderItemGetModel(
      {this.condition,
        this.categoryCode,
        this.productGroup,
        this.itemNo,
        this.itemName,
        this.baseUnitOfMeasure,
        this.unitPrice,
        this.imageUrl,
        this.orderQty,
        this.categoryWiseTotalQty});

  OrderItemGetModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    categoryCode = json['category_code'];
    productGroup = json['product_group'];
    itemNo = json['item_no'];
    itemName = json['item_name'];
    baseUnitOfMeasure = json['base_unit_of_measure'];
    unitPrice = json['unit_price'];
    imageUrl = json['image_url'];
    orderQty = json['order_qty'];
    categoryWiseTotalQty = json['category_wise_total_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['category_code'] = this.categoryCode;
    data['product_group'] = this.productGroup;
    data['item_no'] = this.itemNo;
    data['item_name'] = this.itemName;
    data['base_unit_of_measure'] = this.baseUnitOfMeasure;
    data['unit_price'] = this.unitPrice;
    data['image_url'] = this.imageUrl;
    data['order_qty'] = this.orderQty;
    data['category_wise_total_qty'] = this.categoryWiseTotalQty;
    return data;
  }
}