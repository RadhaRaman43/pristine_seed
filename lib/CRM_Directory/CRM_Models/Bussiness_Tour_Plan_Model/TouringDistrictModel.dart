class TouringDistrictModel {
  String? condition;
  String? totalRows;
  String? district;
  String? type;

  TouringDistrictModel({this.condition, this.totalRows, this.district,  this.type});

  TouringDistrictModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    district = json['district'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['district'] = this.district;
    data['type'] = this.type;
    return data;
  }
}