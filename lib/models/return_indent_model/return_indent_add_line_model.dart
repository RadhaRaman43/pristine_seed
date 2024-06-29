class ReturnIndentAddLineReponse {
  String? condition;
  String? message;
  String? returnNo;
  String? itemNo;
  int? lineNo;
  String? indentNo;
  int? indentLineNo;
  double? returnUnusedQty;
  double? returnBadQty;
  double? returnTotalQty;
  String? createdOn;
  String? displayName;

  ReturnIndentAddLineReponse(
      {this.condition,
        this.message,
        this.returnNo,
        this.itemNo,
        this.lineNo,
        this.indentNo,
        this.indentLineNo,
        this.returnUnusedQty,
        this.returnBadQty,
        this.returnTotalQty,
        this.createdOn,
        this.displayName});

  ReturnIndentAddLineReponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    returnNo = json['return_no'];
    itemNo = json['item_no'];
    lineNo = json['line_no'];
    indentNo = json['indent_no'];
    indentLineNo = json['indent_line_no'];
    returnUnusedQty = json['return_unused_qty'];
    returnBadQty = json['return_bad_qty'];
    returnTotalQty = json['return_total_qty'];
    createdOn = json['created_on'];
    displayName = json['display_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['return_no'] = this.returnNo;
    data['item_no'] = this.itemNo;
    data['line_no'] = this.lineNo;
    data['indent_no'] = this.indentNo;
    data['indent_line_no'] = this.indentLineNo;
    data['return_unused_qty'] = this.returnUnusedQty;
    data['return_bad_qty'] = this.returnBadQty;
    data['return_total_qty'] = this.returnTotalQty;
    data['created_on'] = this.createdOn;
    data['display_name'] = this.displayName;
    return data;
  }
}