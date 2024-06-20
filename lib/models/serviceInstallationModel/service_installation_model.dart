class ServiceInstallationResponse {
  String? condition;
  String? serviceType;
  int? serviceCount;

  ServiceInstallationResponse(
      {this.condition, this.serviceType, this.serviceCount});

  ServiceInstallationResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    serviceType = json['service_type'];
    serviceCount = json['service_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['service_type'] = this.serviceType;
    data['service_count'] = this.serviceCount;
    return data;
  }
}