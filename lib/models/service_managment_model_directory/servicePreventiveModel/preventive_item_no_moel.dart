class PreventiveItemNoResponse {
  String? condition;
  String? message;
  String? itemCode;
  String? componentProductCode;
  double? componentQuantity;
  String? displayName;
  double? costPerUnit;
  int? isWarranty;
  PreventiveItemNoResponse(
      {this.condition,
        this.message,
        this.itemCode,
        this.componentProductCode,
        this.componentQuantity,
        this.displayName,
        this.isWarranty,
        this.costPerUnit});

  PreventiveItemNoResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    itemCode = json['item_code'];
    displayName = json['display_name'];
    componentProductCode = json['component_product_code'];
    componentQuantity = json['component_quantity'];
    isWarranty = json['is_warranty'];

    costPerUnit = json['cost_per_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['item_code'] = this.itemCode;
    data['component_product_code'] = this.componentProductCode;
    data['component_quantity'] = this.componentQuantity;
    data['display_name'] = this.displayName;
    data['is_warranty'] = this.isWarranty;
    data['cost_per_unit'] = this.costPerUnit;
    return data;
  }
}