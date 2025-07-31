class CallDashboardModel {
  String? condition;
  String? message;
  String? geoName;
  List<Records>? records;

  CallDashboardModel({this.condition, this.message, this.geoName, this.records});

  CallDashboardModel.fromJson(Map<String, dynamic> json) {
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
  String? geoName;
  String? geoValue;
  String? emailId;
  String? employee;
  int? newCall;
  int? followUpCall;
  int? paymentCall;

  Records(
      {this.geoName,
        this.geoValue,
        this.emailId,
        this.employee,
        this.newCall,
        this.followUpCall,
        this.paymentCall});

  Records.fromJson(Map<String, dynamic> json) {
    geoName = json['geo_name'];
    geoValue = json['geo_value'];
    emailId = json['email_id'];
    employee = json['employee'];
    newCall = json['new_call'];
    followUpCall = json['Follow_Up_call'];
    paymentCall = json['Payment_call'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['geo_name'] = this.geoName;
    data['geo_value'] = this.geoValue;
    data['email_id'] = this.emailId;
    data['employee'] = this.employee;
    data['new_call'] = this.newCall;
    data['Follow_Up_call'] = this.followUpCall;
    data['Payment_call'] = this.paymentCall;
    return data;
  }
}