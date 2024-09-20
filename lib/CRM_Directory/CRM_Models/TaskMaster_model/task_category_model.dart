class TaskSalesProductCategoryLinesModel {
  String productCategoryCode;

  TaskSalesProductCategoryLinesModel({required this.productCategoryCode});

  Map<String, dynamic> toJson() => {
    'product_category_code': productCategoryCode,
  };
}