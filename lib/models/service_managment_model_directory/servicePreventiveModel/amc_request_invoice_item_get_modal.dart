class AMCRequestInvoiceItemGetModal {
  String? condition;
  String? message;
  String? itemNo;
  String? itemName;

  AMCRequestInvoiceItemGetModal({
    this.condition,
    this.message,
    this.itemNo,
    this.itemName});

  AMCRequestInvoiceItemGetModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    itemNo = json['item_no'];
    itemName = json['item_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['item_no'] = this.itemNo;
    data['item_name'] = this.itemName;
    return data;
  }
}