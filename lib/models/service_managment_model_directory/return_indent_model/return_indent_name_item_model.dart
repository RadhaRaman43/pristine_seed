class IndentItemResponse {
  String? condition;
  String? message;
  String? indentNo;
  String? displayName;
  int? lineNo;
  String? itemNo;
  String? customerName;
  double? unusedQty;
  double? badQty;
  double? totalQty;

  IndentItemResponse(
      {this.condition,
        this.message,
        this.indentNo,
        this.customerName,
        this.displayName,
        this.lineNo,
        this.itemNo,
        this.unusedQty,
        this.badQty,
        this.totalQty});

  IndentItemResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    indentNo = json['indent_no'];
    customerName = json['customer_name'];
    displayName = json['display_name'];
    lineNo = json['line_no'];
    itemNo = json['item_no'];
    unusedQty = json['unused_qty'];
    badQty = json['bad_qty'];
    totalQty = json['total_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['indent_no'] = this.indentNo;
    data['customer_name'] = this.customerName;
    data['display_name'] = this.displayName;
    data['line_no'] = this.lineNo;
    data['item_no'] = this.itemNo;
    data['unused_qty'] = this.unusedQty;
    data['bad_qty'] = this.badQty;
    data['total_qty'] = this.totalQty;
    return data;
  }
}