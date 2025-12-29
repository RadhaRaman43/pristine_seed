class DepartmnetModal {
  String? condition;
  String? departmentId;
  String? departmentDesc;
  String? createdBy;
  String? createdOn;

  DepartmnetModal(
      {this.condition,
        this.departmentId,
        this.departmentDesc,
        this.createdBy,
        this.createdOn});

  DepartmnetModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    departmentId = json['department_id'];
    departmentDesc = json['department_desc'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['department_id'] = this.departmentId;
    data['department_desc'] = this.departmentDesc;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    return data;
  }
}