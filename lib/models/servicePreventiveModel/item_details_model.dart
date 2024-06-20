class  PreventiveItemDetailsResponse {
  String? condition;
  String? itemCode;
  String? componentProductCode;
  double? componentQuantity;
  double? componentPrice;
  String? displayName;

  PreventiveItemDetailsResponse(
      {this.condition,
        this.itemCode,
        this.componentProductCode,
        this.componentQuantity,
        this.componentPrice,
        this.displayName});

  PreventiveItemDetailsResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    itemCode = json['item_code'];
    componentProductCode = json['component_product_code'];
    componentQuantity = json['component_quantity'];
    componentPrice = json['component_price'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['item_code'] = this.itemCode;
    data['component_product_code'] = this.componentProductCode;
    data['component_quantity'] = this.componentQuantity;
    data['component_price'] = this.componentPrice;
    data['display_name'] = this.displayName;
    return data;
  }
}