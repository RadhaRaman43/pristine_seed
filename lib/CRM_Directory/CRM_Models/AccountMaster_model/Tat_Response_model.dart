class TatResponseModel {
  String? condition;
  String? message;
  int? id;
  String? responseType;
  int? responseTime;
  String? responseDescription;
  String? createdBy;
  String? createdOn;

  TatResponseModel(
      {this.condition,
        this.message,
        this.id,
        this.responseType,
        this.responseTime,
        this.responseDescription,
        this.createdBy,
        this.createdOn});

  TatResponseModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    id = json['id'];
    responseType = json['response_type'];
    responseTime = json['response_time'];
    responseDescription = json['response_description'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['id'] = this.id;
    data['response_type'] = this.responseType;
    data['response_time'] = this.responseTime;
    data['response_description'] = this.responseDescription;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    return data;
  }
}