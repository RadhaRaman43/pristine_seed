/*
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class ComplainRaiseModal{
  String? condition;
  String? message;

  ComplainRaiseModal({this.condition, this.message});

  ComplainRaiseModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['message'] = message;
    return data;
  }
}

