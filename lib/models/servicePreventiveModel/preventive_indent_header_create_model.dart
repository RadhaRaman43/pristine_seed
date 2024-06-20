class ServicePreventiveIndentHeaderResponse {
  String? condition;
  String? message;
  String? indentNo;
  String? serviceType;
  String? serviceId;
  String? serviceNo;
  String? createdOn;
  String? createdBy;
  String? indentStatus;
  String? updatedOn;

  ServicePreventiveIndentHeaderResponse(
      {this.condition,
        this.message,
        this.indentNo,
        this.serviceType,
        this.serviceId,
        this.serviceNo,
        this.createdOn,
        this.createdBy,
        this.indentStatus,
        this.updatedOn});

  ServicePreventiveIndentHeaderResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    indentNo = json['indent_no'];
    serviceType = json['service_type'];
    serviceId = json['service_id'];
    serviceNo = json['service_no'];
    createdOn = json['created_on'];
    createdBy = json['created_by'];
    indentStatus = json['indent_status'];
    updatedOn = json['updated_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['indent_no'] = this.indentNo;
    data['service_type'] = this.serviceType;
    data['service_id'] = this.serviceId;
    data['service_no'] = this.serviceNo;
    data['created_on'] = this.createdOn;
    data['created_by'] = this.createdBy;
    data['indent_status'] = this.indentStatus;
    data['updated_on'] = this.updatedOn;
    return data;
  }
}