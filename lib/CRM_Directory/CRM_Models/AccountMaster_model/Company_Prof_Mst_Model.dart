class CompanyProfileMstModel {
  String? condition;
  String? totalRows;
  int? id;
  String? typeOfCompany;
  String? description;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;

  CompanyProfileMstModel(
      {this.condition,
        this.totalRows,
        this.id,
        this.typeOfCompany,
        this.description,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn});

  CompanyProfileMstModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    id = json['id'];
    typeOfCompany = json['type_of_company'];
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
    data['id'] = this.id;
    data['type_of_company'] = this.typeOfCompany;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    return data;
  }
}