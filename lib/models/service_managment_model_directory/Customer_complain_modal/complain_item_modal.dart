/*
// Example Usage
Map<String, dynamic> map = jsonDecode(<myJSONString>);
var myRootNode = Root.fromJson(map);
*/
class ComplainItemModal {
  String? condition;
  String? itemno;
  String? itemname;

  ComplainItemModal({this.condition, this.itemno, this.itemname});

  ComplainItemModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    itemno = json['item_no'];
    itemname = json['item_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['condition'] = condition;
    data['item_no'] = itemno;
    data['item_name'] = itemname;
    return data;
  }
}

