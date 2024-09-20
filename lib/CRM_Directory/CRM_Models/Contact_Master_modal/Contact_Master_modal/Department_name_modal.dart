class DepartNameModal {
  String? condition;
  int? deptId;
  String? deptName;
  String? createdOn;
  String? createdBy;

  DepartNameModal(
      {this.condition,
        this.deptId,
        this.deptName,
        this.createdOn,
        this.createdBy});

  DepartNameModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    deptId = json['dept_id'];
    deptName = json['dept_name'];
    createdOn = json['created_on'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['dept_id'] = this.deptId;
    data['dept_name'] = this.deptName;
    data['created_on'] = this.createdOn;
    data['created_by'] = this.createdBy;
    return data;
  }
}