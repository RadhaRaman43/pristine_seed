class ServiceInventoryViewListModel {
  String? condition;
  String? indentNo;
  String? itemNo;
  String? itemName;
  double? movableQty;
  double? goodQty;
  double? returnQty;
  double? badQty;
  double? returnBadQty;

  ServiceInventoryViewListModel(
      {this.condition,
        this.indentNo,
        this.itemNo,
        this.itemName,
        this.movableQty,
        this.goodQty,
        this.returnQty,
        this.badQty,
        this.returnBadQty});

  ServiceInventoryViewListModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    indentNo = json['indent_no'];
    itemNo = json['item_no'];
    itemName = json['item_name'];
    movableQty = json['movable_qty'];
    goodQty = json['good_qty'];
    returnQty = json['return_qty'];
    badQty = json['bad_qty'];
    returnBadQty = json['return_bad_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['indent_no'] = this.indentNo;
    data['item_no'] = this.itemNo;
    data['item_name'] = this.itemName;
    data['movable_qty'] = this.movableQty;
    data['good_qty'] = this.goodQty;
    data['return_qty'] = this.returnQty;
    data['bad_qty'] = this.badQty;
    data['return_bad_qty'] = this.returnBadQty;
    return data;
  }
}