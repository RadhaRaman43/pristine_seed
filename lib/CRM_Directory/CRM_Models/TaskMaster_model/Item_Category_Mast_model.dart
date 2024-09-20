class ItemCategoryMstModel {
  String? condition;
  String? categoryCode;
  String? categoryName;
  int? id;
  String? taskId;
  String? salesCycleId;
  String? quoteId;
  String? createdBy;
  String? createdOn;
  int? isSelected;

  ItemCategoryMstModel(
      {this.condition,
        this.categoryCode,
        this.categoryName,
        this.id,
        this.taskId,
        this.salesCycleId,
        this.quoteId,
        this.createdBy,
        this.createdOn,
        this.isSelected});

  ItemCategoryMstModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    categoryCode = json['category_code'];
    categoryName = json['category_name'];
    id = json['id'];
    taskId = json['task_id'];
    salesCycleId = json['sales_cycle_id'];
    quoteId = json['quote_id'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    isSelected = json['is_selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['category_code'] = this.categoryCode;
    data['category_name'] = this.categoryName;
    data['id'] = this.id;
    data['task_id'] = this.taskId;
    data['sales_cycle_id'] = this.salesCycleId;
    data['quote_id'] = this.quoteId;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['is_selected'] = this.isSelected;
    return data;
  }
}