/*
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class ComplainAddressModal {
  String? condition;
  String? customeraddress;
  String? customerpincode;
  String? customerstate;
  String? customerifsccode;
  String? customerarea;

  ComplainAddressModal({this.condition, this.customeraddress, this.customerpincode, this.customerstate, this.customerifsccode, this.customerarea});

  ComplainAddressModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    customeraddress = json['customer_address'];
    customerpincode = json['customer_pincode'];
    customerstate = json['customer_state'];
    customerifsccode = json['customer_ifsc_code'];
    customerarea = json['customer_area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['customer_address'] = customeraddress;
    data['customer_pincode'] = customerpincode;
    data['customer_state'] = customerstate;
    data['customer_ifsc_code'] = customerifsccode;
    data['customer_area'] = customerarea;
    return data;
  }
}

