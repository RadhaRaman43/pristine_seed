class CompanyProfileMstModel {
  String? condition;
  String? totalRows;
  String? code;
  String? description;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;

  CompanyProfileMstModel(
      {this.condition,
        this.totalRows,
        this.code,
        this.description,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn});

  CompanyProfileMstModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    code = json['code'];
    description = json['description'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['code'] = this.code;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    return data;
  }
}