class ReturnIndentHeaderCreateResponse {
  String? condition;
  String? message;
  String? returnNo;
  String? locationCode;
  String? createdBy;
  String? createdOn;
  int? isDone;
  String? completedOn;
  List<Lines>? lines;

  ReturnIndentHeaderCreateResponse(
      {this.condition,
        this.message,
        this.returnNo,
        this.locationCode,
        this.createdBy,
        this.createdOn,
        this.isDone,
        this.completedOn,
        this.lines});

  ReturnIndentHeaderCreateResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    returnNo = json['return_no'];
    locationCode = json['location_code'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    isDone = json['is_done'];
    completedOn = json['completed_on'];
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
    data['message'] = this.message;
    data['return_no'] = this.returnNo;
    data['location_code'] = this.locationCode;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['is_done'] = this.isDone;
    data['completed_on'] = this.completedOn;
    if (this.lines != null) {
      data['lines'] = this.lines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lines {
  String? returnNo;
  String? itemNo;
  double? unusedQty;
  double? damageQty;
  double? totalQty;
  double? returnUnusedQty;
  double? returnDamageQty;
  double? totalReturnQty;

  Lines(
      {this.returnNo,
        this.itemNo,
        this.unusedQty,
        this.damageQty,
        this.totalQty,
        this.returnUnusedQty,
        this.returnDamageQty,
        this.totalReturnQty});

  Lines.fromJson(Map<String, dynamic> json) {
    returnNo = json['return_no'];
    itemNo = json['item_no'];
    unusedQty = json['unused_qty'];
    damageQty = json['damage_qty'];
    totalQty = json['total_qty'];
    returnUnusedQty = json['return_unused_qty'];
    returnDamageQty = json['return_damage_qty'];
    totalReturnQty = json['total_return_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['return_no'] = this.returnNo;
    data['item_no'] = this.itemNo;
    data['unused_qty'] = this.unusedQty;
    data['damage_qty'] = this.damageQty;
    data['total_qty'] = this.totalQty;
    data['return_unused_qty'] = this.returnUnusedQty;
    data['return_damage_qty'] = this.returnDamageQty;
    data['total_return_qty'] = this.totalReturnQty;
    return data;
  }
}