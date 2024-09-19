class RegionModel {
  String? condition;
  String? regionCode;
  String? regionName;
  String? userName;
  String? updatedOn;
  String? updatedBy;

  RegionModel(
      {this.condition,
        this.regionCode,
        this.regionName,
        this.userName,
        this.updatedOn,
        this.updatedBy});

  RegionModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    regionCode = json['region_code'];
    regionName = json['region_name'];
    userName = json['user_name'];
    updatedOn = json['updated_on'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['region_code'] = this.regionCode;
    data['region_name'] = this.regionName;
    data['user_name'] = this.userName;
    data['updated_on'] = this.updatedOn;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}