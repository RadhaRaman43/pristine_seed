class FunnelDashboardModel {
  String? condition;
  String? message;
  String? geoName;
  dynamic totalSuspectPrice;
  dynamic totalProspectPrice;
  dynamic totalProposePrice;

  FunnelDashboardModel(
      {this.condition,
        this.message,
        this.geoName,
        this.totalSuspectPrice,
        this.totalProspectPrice,
        this.totalProposePrice});

  FunnelDashboardModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    geoName = json['geo_name'];
    totalSuspectPrice = json['total_suspect_price'];
    totalProspectPrice = json['total_prospect_price'];
    totalProposePrice = json['total_propose_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['geo_name'] = this.geoName;
    data['total_suspect_price'] = this.totalSuspectPrice;
    data['total_prospect_price'] = this.totalProspectPrice;
    data['total_propose_price'] = this.totalProposePrice;
    return data;
  }
}