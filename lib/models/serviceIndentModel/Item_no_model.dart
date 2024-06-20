class ItemNoResponse {
  String? condition;
  String? message;
  String? itemCode;
  String? componentProductCode;
  double? componentQuantity;
  String? displayName;
  ItemNoResponse(
      {this.condition,
        this.message,
        this.itemCode,
        this.componentProductCode,
        this.componentQuantity,
      this.displayName});

  ItemNoResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    itemCode = json['item_code'];
    displayName = json['display_name'];
    componentProductCode = json['component_product_code'];
    componentQuantity = json['component_quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['item_code'] = this.itemCode;
    data['component_product_code'] = this.componentProductCode;
    data['component_quantity'] = this.componentQuantity;
    data['display_name'] = this.displayName;
    return data;
  }
}