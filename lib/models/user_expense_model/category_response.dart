class CatagoryResponse {
  String? condition;
  int? id;
  String? expenseName;
  int? imageRequired;
  int? isLodging;
  int? isKm;

  CatagoryResponse(
      {
        this.condition,
        this.id,
        this.expenseName,
        this.imageRequired,
        this.isLodging,
        this.isKm});

  CatagoryResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    id = json['id'];
    expenseName = json['expense_name'];
    imageRequired = json['image_required'];
    isLodging = json['is_lodging'];
    isKm = json['is_km'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['id'] = this.id;
    data['expense_name'] = this.expenseName;
    data['image_required'] = this.imageRequired;
    data['is_lodging'] = this.isLodging;
    data['is_km'] = this.isKm;
    return data;
  }
}