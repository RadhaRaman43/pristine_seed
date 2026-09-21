class SalesForceCastHeaderModal {
  String? condition;
  String? message;
  String? salesForecastId;
  String? monthYear;
  String? salesForecastStatus;
  String? createdBy;
  String? createdFullName;
  String? createdOn;
  String? remarks;
  String? regionName;
  String? clusterName;
  dynamic? totalQuoteQty;
  dynamic? totalQuoteApprovedPrice;
    List<TotalMonthYearQty>? totalMonthYearQty;
  List<Lines>? lines;

  SalesForceCastHeaderModal(
      {this.condition,
        this.message,
        this.salesForecastId,
        this.monthYear,
        this.salesForecastStatus,
        this.createdBy,
        this.createdFullName,
        this.createdOn,
        this.remarks,
        this.regionName,
        this.clusterName,
        this.totalQuoteQty,
        this.totalQuoteApprovedPrice,
        this.totalMonthYearQty,
        this.lines});

  SalesForceCastHeaderModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    salesForecastId = json['sales_forecast_id'];
    monthYear = json['month_year'];
    salesForecastStatus = json['sales_forecast_status'];
    createdBy = json['created_by'];
    createdFullName = json['created_full_name'];
    createdOn = json['created_on'];
    remarks = json['remarks'];
    regionName = json['region_name'];
    clusterName = json['cluster_name'];
    totalQuoteQty = json['total_quote_qty'];
    totalQuoteApprovedPrice = json['total_quote_approved_price'];
    if (json['total_month_year_qty'] != null) {
      totalMonthYearQty = <TotalMonthYearQty>[];
      json['total_month_year_qty'].forEach((v) {
        totalMonthYearQty!.add(new TotalMonthYearQty.fromJson(v));
      });
    }
    if (json['lines'] != null) {
      lines = <Lines>[];
      json['lines'].forEach((v) {
        lines!.add(new Lines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['sales_forecast_id'] = this.salesForecastId;
    data['month_year'] = this.monthYear;
    data['sales_forecast_status'] = this.salesForecastStatus;
    data['created_by'] = this.createdBy;
    data['created_full_name'] = this.createdFullName;
    data['created_on'] = this.createdOn;
    data['remarks'] = this.remarks;
    data['region_name'] = this.regionName;
    data['cluster_name'] = this.clusterName;
    data['total_quote_qty'] = this.totalQuoteQty;
    data['total_quote_approved_price'] = this.totalQuoteApprovedPrice;
    if (this.totalMonthYearQty != null) {
      data['total_month_year_qty'] =
          this.totalMonthYearQty!.map((v) => v.toJson()).toList();
    }
    if (this.lines != null) {
      data['lines'] = this.lines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lines {
  String? salesForecastId;
  String? salesCycleId;
  String? quoteId;
  dynamic? quoteLineNo;
  String? accountCode;
  String? accountName;
  String? itemCode;
  String? itemName;
  String? itemDescription;
  String? itemCategoryCode;
  String? itemParentCategoryCode;
  dynamic? quoteQty;
  dynamic? quoteApprovedAmountPerUnit;
  String? itemVarient;
  String? requiredRegionName;
  String? requiredClusterName;

  List<ForecastMonth> forecastMonths = [];

  Lines(
      {this.salesForecastId,
        this.salesCycleId,
        this.quoteId,
        this.quoteLineNo,
        this.accountCode,
        this.accountName,
        this.itemCode,
        this.itemName,
        this.itemDescription,
        this.itemCategoryCode,
        this.itemParentCategoryCode,
        this.quoteQty,
        this.quoteApprovedAmountPerUnit,
        this.itemVarient,
        this.requiredRegionName,
        this.requiredClusterName});

  Lines.fromJson(Map<String, dynamic> json) {
    salesForecastId = json['sales_forecast_id'];
    salesCycleId = json['sales_cycle_id'];
    quoteId = json['quote_id'];
    quoteLineNo = json['quote_line_no'];
    accountCode = json['account_code'];
    accountName = json['account_name'];
    itemCode = json['item_code'];
    itemName = json['item_name'];
    itemDescription = json['item_description'];
    itemCategoryCode = json['item_category_code'];
    itemParentCategoryCode = json['item_parent_category_code'];
    quoteQty = json['quote_qty'];
    quoteApprovedAmountPerUnit = json['quote_approved_amount_per_unit'];
    itemVarient = json['item_varient'];
    requiredRegionName = json['required_region_name'];
    requiredClusterName = json['required_cluster_name'];

    json.forEach((key, value) {
      if (key.contains('|')) {List<String> parts = key.split('|');
        forecastMonths.add(
          ForecastMonth(
            key: key,
            monthNo: parts[0],
            month: parts[1],
            year: parts[2],
            value: value,
          ),
        );
      }
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sales_forecast_id'] = this.salesForecastId;
    data['sales_cycle_id'] = this.salesCycleId;
    data['quote_id'] = this.quoteId;
    data['quote_line_no'] = this.quoteLineNo;
    data['account_code'] = this.accountCode;
    data['account_name'] = this.accountName;
    data['item_code'] = this.itemCode;
    data['item_name'] = this.itemName;
    data['item_description'] = this.itemDescription;
    data['item_category_code'] = this.itemCategoryCode;
    data['item_parent_category_code'] = this.itemParentCategoryCode;
    data['quote_qty'] = this.quoteQty;
    data['quote_approved_amount_per_unit'] = this.quoteApprovedAmountPerUnit;
    data['item_varient'] = this.itemVarient;
    data['required_region_name'] = this.requiredRegionName;
    data['required_cluster_name'] = this.requiredClusterName;
    for (var month in forecastMonths) {
      data[month.key] = month.value;
    }
    return data;
  }
}

class TotalMonthYearQty {
  dynamic? srNo;
  dynamic? contMonthNo;
  String? closureMonth;
  String? closureYear;
  dynamic? totalMonthYearQty;

  TotalMonthYearQty(
      {this.srNo,
        this.contMonthNo,
        this.closureMonth,
        this.closureYear,
        this.totalMonthYearQty});

  TotalMonthYearQty.fromJson(Map<String, dynamic> json) {
    srNo = json['sr_no'];
    contMonthNo = json['cont_month_no'];
    closureMonth = json['closure_month'];
    closureYear = json['closure_year'];
    totalMonthYearQty = json['total_month_year_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sr_no'] = this.srNo;
    data['cont_month_no'] = this.contMonthNo;
    data['closure_month'] = this.closureMonth;
    data['closure_year'] = this.closureYear;
    data['total_month_year_qty'] = this.totalMonthYearQty;
    return data;
  }
}
class ForecastMonth {
  String key;
  String monthNo;
  String month;
  String year;
  dynamic value;

  ForecastMonth({
    required this.key,
    required this.monthNo,
    required this.month,
    required this.year,
    required this.value,
  });
}