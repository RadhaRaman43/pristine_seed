class BulkHeaderCreateResponse {
  String? condition;
  String? message;
  String? indentNo;
  String? serviceType;
  String? indentType;
  String? serviceId;
  String? serviceNo;
  String? createdOn;
  String? createdBy;
  String? indentStatus;
  String? updatedOn;
  String? completedOn;
  String? approveOn;
  String? approveBy;
  String? locationCode;
  String? rejectReason;
  List<BulkLines>? lines;
  BulkHeaderCreateResponse(
      {this.condition,
        this.indentNo,
        this.serviceType,
        this.indentType,
        this.serviceId,
        this.serviceNo,
        this.createdOn,
        this.createdBy,
        this.indentStatus,
        this.updatedOn,
        this.locationCode,
        this.lines,
        this.message});

  BulkHeaderCreateResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    indentNo = json['indent_no'];
    message = json['message'];
    serviceType = json['service_type'];
    indentType = json['indent_type'];
    serviceId = json['service_id'];
    serviceNo = json['service_no'];
    createdOn = json['created_on'];
    createdBy = json['created_by'];
    indentStatus = json['indent_status'];
    locationCode = json['location_code'];
    updatedOn = json['updated_on'];
    if (json['lines'] != null) {
      lines = <BulkLines>[];
      json['lines'].forEach((v) {
        lines!.add(new BulkLines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['indent_no'] = this.indentNo;
    data['message'] = this.message;
    data['service_type'] = this.serviceType;
    data['indent_type'] = this.indentType;
    data['service_id'] = this.serviceId;
    data['service_no'] = this.serviceNo;
    data['created_on'] = this.createdOn;
    data['created_by'] = this.createdBy;
    data['indent_status'] = this.indentStatus;
    data['updated_on'] = this.updatedOn;
    data['location_code'] = this.locationCode;
    if (this.lines != null) {
      data['lines'] = this.lines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BulkLines {
  String? indentNo;
  int? lineNo;
  String? itemNo;
  String? itemName;
  double? qty;
  int? isCustomerDamage;
  double? discountPer;
  double? unitPrice;
  double? subTotal;
  double? discountAmount;
  double? totalPrice;
  String? lineStatus;
  String? updatedOn;
  double? qtyIssueFromNav;
  double? consumeQty;
  double? badQty;
  double? remainingQty;
  int? isReturn;
  double? returnQty;
  double? actualUnitPrice;

  BulkLines(
      {this.indentNo,
        this.lineNo,
        this.itemNo,
        this.itemName,
        this.qty,
        this.isCustomerDamage,
        this.discountPer,
        this.unitPrice,
        this.subTotal,
        this.discountAmount,
        this.totalPrice,
        this.lineStatus,
        this.updatedOn,
        this.qtyIssueFromNav,
        this.consumeQty,
        this.badQty,
        this.remainingQty,
        this.isReturn,
        this.returnQty,
        this.actualUnitPrice,});

  BulkLines.fromJson(Map<String, dynamic> json) {
    indentNo = json['indent_no'];
    lineNo = json['line_no'];
    itemNo = json['item_no'];
    itemName = json['item_name'];
    qty = json['qty'];
    isCustomerDamage = json['is_customer_damage'];
    discountPer = json['discount_per'];
    unitPrice = json['unit_price'];
    subTotal = json['sub_total'];
    discountAmount = json['discount_amount'];
    totalPrice = json['total_price'];
    lineStatus = json['line_status'];
    updatedOn = json['updated_on'];
    qtyIssueFromNav = json['qty_issue_from_nav'];
    consumeQty = json['consume_qty'];
    badQty = json['bad_qty'];
    remainingQty = json['remaining_qty'];
    isReturn = json['is_return'];
    returnQty = json['return_qty'];
    actualUnitPrice = json['actual_unit_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['indent_no'] = this.indentNo;
    data['line_no'] = this.lineNo;
    data['item_no'] = this.itemNo;
    data['item_name'] = this.itemName;
    data['qty'] = this.qty;
    data['is_customer_damage'] = this.isCustomerDamage;
    data['discount_per'] = this.discountPer;
    data['unit_price'] = this.unitPrice;
    data['sub_total'] = this.subTotal;
    data['discount_amount'] = this.discountAmount;
    data['total_price'] = this.totalPrice;
    data['line_status'] = this.lineStatus;
    data['updated_on'] = this.updatedOn;
    data['qty_issue_from_nav'] = this.qtyIssueFromNav;
    data['consume_qty'] = this.consumeQty;
    data['bad_qty'] = this.badQty;
    data['remaining_qty'] = this.remainingQty;
    data['is_return'] = this.isReturn;
    data['return_qty'] = this.returnQty;
    data['actual_unit_price'] = this.actualUnitPrice;
    return data;
  }
}