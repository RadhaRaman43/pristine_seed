class SalesCycleUpdateStatusModal {
  String? condition;
  String? message;
  String? quoteId;

  SalesCycleUpdateStatusModal({this.condition, this.message, this.quoteId});

  SalesCycleUpdateStatusModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    quoteId = json['quote_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['quote_id'] = this.quoteId;
    return data;
  }
}