class ServiceOffsiteClosureResponse {
  String? condition;
  String? message;

  ServiceOffsiteClosureResponse({this.condition, this.message});

  ServiceOffsiteClosureResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    return data;
  }
}