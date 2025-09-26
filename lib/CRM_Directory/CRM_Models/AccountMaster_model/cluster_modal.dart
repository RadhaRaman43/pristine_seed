class ClusterModal {
  String? condition;
  int? id;
  String? geoName;
  String? geoValue;
  String? managerEmail;
  int? parentId;

  ClusterModal(
      {this.condition,
        this.id,
        this.geoName,
        this.geoValue,
        this.managerEmail,
        this.parentId});

  ClusterModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    id = json['id'];
    geoName = json['geo_name'];
    geoValue = json['geo_value'];
    managerEmail = json['manager_email'];
    parentId = json['parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['id'] = this.id;
    data['geo_name'] = this.geoName;
    data['geo_value'] = this.geoValue;
    data['manager_email'] = this.managerEmail;
    data['parent_id'] = this.parentId;
    return data;
  }
}


