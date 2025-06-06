class GetMasterTypeModel {
  String? condition;
  String? message;
  String? code;
  String? description;
  String? createdBy;
  String? createdOn;
  List<CustomList>? list;

  GetMasterTypeModel({
    this.condition,
    this.message,
    this.code,
    this.description,
    this.createdBy,
    this.createdOn,
    this.list});

  GetMasterTypeModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    code = json['code'];
    description = json['description'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    if (json['list'] != null) {
      list = <CustomList>[];
      json['list'].forEach((v) {
        list!.add(new CustomList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['code'] = this.code;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomList {
  String? value;

  CustomList({this.value});

  CustomList.fromJson(Map<String, dynamic> json) {
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this.value;
    return data;
  }
}
