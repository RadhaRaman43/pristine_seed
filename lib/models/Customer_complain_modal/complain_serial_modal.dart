/*
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class ComplainSerialModal {
  String? condition;
  String? serialno;

  ComplainSerialModal({this.condition, this.serialno});

  ComplainSerialModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    serialno = json['serial_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['serial_no'] = serialno;
    return data;
  }
}

