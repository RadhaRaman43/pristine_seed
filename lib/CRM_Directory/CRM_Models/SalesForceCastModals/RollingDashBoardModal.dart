class RollingDashBoardModal {
  String? condition;
  String? message;
  String? geoName;
  List<Records>? records;

  RollingDashBoardModal({this.condition, this.geoName, this.records});

  RollingDashBoardModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    geoName = json['geo_name'];
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(new Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['geo_name'] = this.geoName;
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
  String? emailId;
  String? employee;
  String? geoName;
  String? geoValue;
  dynamic? totalQty;
  dynamic? totalAmount;
  dynamic? grandTotalQty;
  dynamic? grandTotalAmount;

  Records(
      {this.geoName,
        this.geoValue,
        this.emailId,
        this.employee,
        this.totalQty,
        this.totalAmount,
        this.grandTotalQty,
        this.grandTotalAmount});

  Records.fromJson(Map<String, dynamic> json) {
    geoName = json['geo_name'];
    geoValue = json['geo_value'];
    emailId = json['email_id'];
    employee = json['employee'];
    totalQty = json['total_qty'];
    totalAmount = json['total_amount'];
    grandTotalQty = json['grand_total_qty'];
    grandTotalAmount = json['grand_total_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['geo_name'] = this.geoName;
    data['geo_value'] = this.geoValue;
    data['email_id'] = this.emailId;
    data['employee'] = this.employee;
    data['total_qty'] = this.totalQty;
    data['total_amount'] = this.totalAmount;
    data['grand_total_qty'] = this.grandTotalQty;
    data['grand_total_amount'] = this.grandTotalAmount;
    return data;
  }
}