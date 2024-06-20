class LogoutResponse{

  String? condition;
  String? action;
  LogoutResponse({this.condition, this.action});

  LogoutResponse.fromJson(Map<String, dynamic> json) {
  condition = json['condition'];
  action = json['action'];
  }
  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = Map<String, dynamic>();
  data['condition'] = condition;
  data['action'] = action;
  return data;
  }

}