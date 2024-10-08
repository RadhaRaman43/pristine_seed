class ProductCategoryWiseAmtModel {
  String? condition;
  String? totalRows;
  int? id;
  String? saleCycleId;
  String? productCategory;
  double? estimatedAmount;
  String? totalEstimatedAmount;
  double? budgetAmount;
  String? totalBudgetAmount;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;
  String? productCategoryName;

  ProductCategoryWiseAmtModel(
      {this.condition,
        this.totalRows,
        this.id,
        this.saleCycleId,
        this.productCategory,
        this.estimatedAmount,
        this.totalEstimatedAmount,
        this.budgetAmount,
        this.totalBudgetAmount,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
        this.productCategoryName});

  ProductCategoryWiseAmtModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    id = json['id'];
    saleCycleId = json['sale_cycle_id'];
    productCategory = json['product_category'];
    estimatedAmount = json['estimated_amount'];
    totalEstimatedAmount = json['total_estimated_amount'];
    budgetAmount = json['budget_amount'];
    totalBudgetAmount = json['total_budget_amount'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
    productCategoryName = json['product_category_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['id'] = this.id;
    data['sale_cycle_id'] = this.saleCycleId;
    data['product_category'] = this.productCategory;
    data['estimated_amount'] = this.estimatedAmount;
    data['total_estimated_amount'] = this.totalEstimatedAmount;
    data['budget_amount'] = this.budgetAmount;
    data['total_budget_amount'] = this.totalBudgetAmount;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    data['product_category_name'] = this.productCategoryName;
    return data;
  }
}