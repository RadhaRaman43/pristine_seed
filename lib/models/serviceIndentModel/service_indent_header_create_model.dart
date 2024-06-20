class IndentHeaderCreateResponse {
  String? condition;
  String? message;
  String? indentNo;
  String? serviceType;
  String? serviceId;
  String? serviceNo;
  String? createdOn;
  String? createdBy;
  String? indentStatus;
  String? updatedOn;
  String? completedOn;
  String? approveOn;
  String? approveBy;
  String? rejectReason;
  List<Lines>? lines;
  IndentHeaderCreateResponse(
      {this.condition,
        this.indentNo,
        this.serviceType,
        this.serviceId,
        this.serviceNo,
        this.createdOn,
        this.createdBy,
        this.indentStatus,
        this.updatedOn,
        this.lines,
      this.message});

  IndentHeaderCreateResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    indentNo = json['indent_no'];
    message = json['message'];
    serviceType = json['service_type'];
    serviceId = json['service_id'];
    serviceNo = json['service_no'];
    createdOn = json['created_on'];
    createdBy = json['created_by'];
    indentStatus = json['indent_status'];
    updatedOn = json['updated_on'];
    if (json['lines'] != null) {
      lines = <Lines>[];
      json['lines'].forEach((v) {
        lines!.add(new Lines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['indent_no'] = this.indentNo;
    data['message'] = this.message;
    data['service_type'] = this.serviceType;
    data['service_id'] = this.serviceId;
    data['service_no'] = this.serviceNo;
    data['created_on'] = this.createdOn;
    data['created_by'] = this.createdBy;
    data['indent_status'] = this.indentStatus;
    data['updated_on'] = this.updatedOn;
    if (this.lines != null) {
      data['lines'] = this.lines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lines {
  String? indentNo;
  int? lineNo;
  String? itemNo;
  String? itemName;
  double? qty;
  String? lineStatus;
  String? updatedOn;
  double? qtyIssueFromNav;
  double? consumeQty;
  double? badQty;
  double? subTotal;
  double? discountAmount;
  double? totalPrice;

  Lines(
      {this.indentNo,
        this.lineNo,
        this.itemNo,
        this.itemName,
        this.qty,
        this.lineStatus,
        this.updatedOn,
        this.qtyIssueFromNav,
        this.consumeQty,
      this.badQty,
       this.totalPrice,
      this.discountAmount,
      this.subTotal});

  Lines.fromJson(Map<String, dynamic> json) {
    indentNo = json['indent_no'];
    lineNo = json['line_no'];
    itemNo = json['item_no'];
    itemName = json['item_name'];
    qty = json['qty'];
    lineStatus = json['line_status'];
    updatedOn = json['updated_on'];
    qtyIssueFromNav = json['qty_issue_from_nav'];
    consumeQty = json['consume_qty'];
    badQty = json['bad_qty'];
    subTotal = json['sub_total'];
    discountAmount = json['discount_amount'];
    totalPrice = json['total_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['indent_no'] = this.indentNo;
    data['line_no'] = this.lineNo;
    data['item_no'] = this.itemNo;
    data['item_name'] = this.itemName;
    data['qty'] = this.qty;
    data['line_status'] = this.lineStatus;
    data['updated_on'] = this.updatedOn;
    data['qty_issue_from_nav'] = this.qtyIssueFromNav;
    data['consume_qty'] = this.consumeQty;
    data['bad_qty'] = this.badQty;
    data['sub_total'] = this.subTotal;
    data['discount_amount'] = this.discountAmount;
    data['total_price'] = this.totalPrice;
    return data;
  }
}