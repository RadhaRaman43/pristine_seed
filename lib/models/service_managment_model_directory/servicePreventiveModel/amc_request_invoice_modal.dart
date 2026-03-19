class AMCRequestInvoiceGetModal {
  String? condition;
  String? invoiceNo;
  String? serviceNo;

  AMCRequestInvoiceGetModal({this.condition, this.invoiceNo, this.serviceNo});

  AMCRequestInvoiceGetModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    invoiceNo = json['invoice_no'];
    serviceNo = json['service_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['invoice_no'] = this.invoiceNo;
    data['service_no'] = this.serviceNo;
    return data;
  }
}