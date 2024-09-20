class ItemQouteWithReportModal {
  String? condition;
  String? message;
  String? flag;
  String? isSpr;
  String? sprNo;
  String? quoteReportUrl;
  String? quoteSpecialPriceReportUrl;

  ItemQouteWithReportModal(
      {this.condition,
        this.message,
        this.flag,
        this.isSpr,
        this.sprNo,
        this.quoteReportUrl,
        this.quoteSpecialPriceReportUrl});

  ItemQouteWithReportModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    flag = json['flag'];
    isSpr = json['is_spr'];
    sprNo = json['spr_no'];
    quoteReportUrl = json['quote_report_url'];
    quoteSpecialPriceReportUrl = json['quote_special_price_report_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['flag'] = this.flag;
    data['is_spr'] = this.isSpr;
    data['spr_no'] = this.sprNo;
    data['quote_report_url'] = this.quoteReportUrl;
    data['quote_special_price_report_url'] = this.quoteSpecialPriceReportUrl;
    return data;
  }
}