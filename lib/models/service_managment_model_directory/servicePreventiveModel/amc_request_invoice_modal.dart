class AMCRequestInvoiceGetModal {
  String? condition;
  String? invoiceNo;
  String? pincode;
  String? serviceNo;

  AMCRequestInvoiceGetModal({this.condition, this.invoiceNo, this.pincode,this.serviceNo});

  AMCRequestInvoiceGetModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    invoiceNo = json['invoice_no'];
    pincode = json['pincode'];
    serviceNo = json['service_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['invoice_no'] = this.invoiceNo;
    data['pincode'] = this.pincode;
    data['service_no'] = this.serviceNo;
    return data;
  }
}