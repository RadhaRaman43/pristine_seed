class OrderItemCategoryModel {
String? condition;
String? categoryCode;
String? categoryDescription;
int? orderQty;
int? itemGroupCount;

OrderItemCategoryModel(
    {this.condition,
      this.categoryCode,
      this.categoryDescription,
      this.orderQty,
      this.itemGroupCount});

OrderItemCategoryModel.fromJson(Map<String, dynamic> json) {
condition = json['condition'];
categoryCode = json['category_code'];
categoryDescription = json['category_description'];
orderQty = json['order_qty'];
itemGroupCount = json['item_group_count'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['condition'] = this.condition;
data['category_code'] = this.categoryCode;
data['category_description'] = this.categoryDescription;
data['order_qty'] = this.orderQty;
data['item_group_count'] = this.itemGroupCount;
return data;
}
}