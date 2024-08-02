/*
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class SelectCustomerComplainModal {
  String? condition;
  String? customerno;
  String? customername;
  //String? message;

  SelectCustomerComplainModal({this.condition, this.customerno, this.customername/*,  this.message*/});

  SelectCustomerComplainModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    customerno = json['customer_no'];
    customername = json['customer_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['customer_no'] = customerno;
    data['customer_name'] = customername;
    return data;
  }
}

