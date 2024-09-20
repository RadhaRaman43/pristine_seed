/*
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class DesignationModal {
  String? condition;
  int? id;
  String? designationname;
  String? createdon;
  String? createdby;
  int? deptid;

  DesignationModal({this.condition, this.id, this.designationname, this.createdon, this.createdby, this.deptid});

  DesignationModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    id = json['id'];
    designationname = json['designation_name'];
    createdon = json['created_on'];
    createdby = json['created_by'];
    deptid = json['dept_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['id'] = id;
    data['designation_name'] = designationname;
    data['created_on'] = createdon;
    data['created_by'] = createdby;
    data['dept_id'] = deptid;
    return data;
  }
}

