class BusinessPlanReportModel {
  String? condition;
  String? message;
  String? bussinessTourPlanReportUrl;

  BusinessPlanReportModel(
      {this.condition, this.message, this.bussinessTourPlanReportUrl});

  BusinessPlanReportModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    bussinessTourPlanReportUrl = json['bussiness_tour_plan_report_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['bussiness_tour_plan_report_url'] = this.bussinessTourPlanReportUrl;
    return data;
  }
}


