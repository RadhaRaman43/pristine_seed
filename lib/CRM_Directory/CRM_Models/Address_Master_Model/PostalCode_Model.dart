class PostalCodeModel {
  String? condition;
  String? pincode;

  PostalCodeModel({this.condition, this.pincode});

  PostalCodeModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['pincode'] = this.pincode;
    return data;
  }
}