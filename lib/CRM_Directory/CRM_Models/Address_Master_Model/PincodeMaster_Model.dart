class PincodeMasterModel {
  String? condition;
  String? totalRows;
  String? stateCode;
  String? stateName;
  String? city;
  String? district;
  String? pincode;
  String? createdBy;
  String? createdOn;

  PincodeMasterModel(
      {this.condition,
        this.totalRows,
        this.stateCode,
        this.stateName,
        this.city,
        this.district,
        this.pincode,
        this.createdBy,
        this.createdOn});

  PincodeMasterModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    stateCode = json['state_code'];
    stateName = json['state_name'];
    city = json['city'];
    district = json['district'];
    pincode = json['pincode'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['state_code'] = this.stateCode;
    data['state_name'] = this.stateName;
    data['city'] = this.city;
    data['district'] = this.district;
    data['pincode'] = this.pincode;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    return data;
  }
}