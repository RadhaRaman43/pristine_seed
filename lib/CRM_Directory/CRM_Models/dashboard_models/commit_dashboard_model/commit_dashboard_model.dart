class CommitDashboardModel {
  String? condition;
  String? message;
  String? geoName;
  List<Records>? records;

  CommitDashboardModel({this.condition, this.message, this.geoName, this.records});

  CommitDashboardModel.fromJson(Map<String, dynamic> json) {
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
  dynamic estimatedAmount;
  dynamic? totalEstimatedAmount;

  Records({this.emailId, this.employee, this.geoName, this.geoValue,this.estimatedAmount, this.totalEstimatedAmount});

  Records.fromJson(Map<String, dynamic> json) {
    emailId = json['email_id'];
    employee = json['employee'];
    geoName = json['geo_name'];
    geoValue = json['geo_value'];
    estimatedAmount = json['estimated_amount'];
    totalEstimatedAmount = json['total_estimated_amount'];  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email_id'] = this.emailId;
    data['employee'] = this.employee;
    data['geo_name'] = this.geoName;
    data['geo_value'] = this.geoValue;
    data['estimated_amount'] = this.estimatedAmount;
    data['total_estimated_amount'] = this.totalEstimatedAmount;
    return data;
  }
}