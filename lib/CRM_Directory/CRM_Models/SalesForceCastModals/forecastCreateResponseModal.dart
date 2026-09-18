class ForecastCreateResponseModal {
  String? condition;
  String? message;
  String? salesForecastId;

  ForecastCreateResponseModal(
      {this.condition, this.message, this.salesForecastId});

  ForecastCreateResponseModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    salesForecastId = json['sales_forecast_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['sales_forecast_id'] = this.salesForecastId;
    return data;
  }
}