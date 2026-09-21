class SalesForceCastListModal {
  String? condition;
  String? totalRows;
  String? salesForecastId;
  String? monthYear;
  String? salesForecastStatus;
  String? createdBy;
  String? createdFullName;
  String? createdOn;
  String? remarks;
  String? reopenBy;
  String? reopenFullName;
  String? reopenOn;
  String? reopenRemarks;
  String? regionName;
  String? clusterName;

  SalesForceCastListModal(
      {this.condition,
        this.totalRows,
        this.salesForecastId,
        this.monthYear,
        this.salesForecastStatus,
        this.createdBy,
        this.createdFullName,
        this.createdOn,
        this.remarks,
        this.reopenBy,
        this.reopenFullName,
        this.reopenOn,
        this.reopenRemarks,
        this.regionName,
        this.clusterName});

  SalesForceCastListModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    salesForecastId = json['sales_forecast_id'];
    monthYear = json['month_year'];
    salesForecastStatus = json['sales_forecast_status'];
    createdBy = json['created_by'];
    createdFullName = json['created_full_name'];
    createdOn = json['created_on'];
    remarks = json['remarks'];
    reopenBy = json['reopen_by'];
    reopenFullName = json['reopen_full_name'];
    reopenOn = json['reopen_on'];
    reopenRemarks = json['reopen_remarks'];
    regionName = json['region_name'];
    clusterName = json['cluster_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['sales_forecast_id'] = this.salesForecastId;
    data['month_year'] = this.monthYear;
    data['sales_forecast_status'] = this.salesForecastStatus;
    data['created_by'] = this.createdBy;
    data['created_full_name'] = this.createdFullName;
    data['created_on'] = this.createdOn;
    data['remarks'] = this.remarks;
    data['reopen_by'] = this.reopenBy;
    data['reopen_full_name'] = this.reopenFullName;
    data['reopen_on'] = this.reopenOn;
    data['reopen_remarks'] = this.reopenRemarks;
    data['region_name'] = this.regionName;
    data['cluster_name'] = this.clusterName;
    return data;
  }
}