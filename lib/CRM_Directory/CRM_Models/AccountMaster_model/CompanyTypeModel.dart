class CompanyTypeModel {
  String? condition;
  String? totalRows;
  int? id;
  String? description;
  String? createdBy;
  String? createdOn;

  CompanyTypeModel(
      {this.condition,
        this.totalRows,
        this.id,
        this.description,
        this.createdBy,
        this.createdOn});

  CompanyTypeModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    id = json['id'];
    description = json['description'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['id'] = this.id;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    return data;
  }
}