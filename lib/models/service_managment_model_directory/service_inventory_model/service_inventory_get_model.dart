class ServiceInventoryGetList {
  String? condition;
  String? totalRows;
  String? itemNo;
  String? displayName;
  double? goodQty;
  double? movableQty;
  double? badQty;

  ServiceInventoryGetList(
      {this.condition,
        this.totalRows,
        this.itemNo,
        this.displayName,
        this.goodQty,
        this.movableQty,
        this.badQty});

  ServiceInventoryGetList.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    itemNo = json['item_no'];
    displayName = json['display_name'];
    goodQty = json['good_qty'];
    movableQty = json['movable_qty'];
    badQty = json['bad_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['item_no'] = this.itemNo;
    data['display_name'] = this.displayName;
    data['good_qty'] = this.goodQty;
    data['movable_qty'] = this.movableQty;
    data['bad_qty'] = this.badQty;
    return data;
  }
}