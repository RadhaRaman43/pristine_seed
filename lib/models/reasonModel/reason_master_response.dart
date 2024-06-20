class ReasonModel {
  String? condition;
  int? iDNo;
  String? reasonCode;
  String? reasonType;
  String? reasonDescription;
  String? created;

  ReasonModel(
      {this.condition,
        this.iDNo,
        this.reasonCode,
        this.reasonType,
        this.reasonDescription,
        this.created});

  ReasonModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    iDNo = json['ID_No'];
    reasonCode = json['Reason_Code'];
    reasonType = json['reason_Type'];
    reasonDescription = json['reason_Description'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['ID_No'] = this.iDNo;
    data['Reason_Code'] = this.reasonCode;
    data['reason_Type'] = this.reasonType;
    data['reason_Description'] = this.reasonDescription;
    data['created'] = this.created;
    return data;
  }
}