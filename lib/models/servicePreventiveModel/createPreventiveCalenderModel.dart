class CreatePreventiveCalender {
  String? condition;
  String? warrantyDate;
  String? message;
  int? pendingPmRequest;

  List<PreventiveRequests>? preventiveRequests;

  CreatePreventiveCalender(
      {this.condition,
        this.warrantyDate,
        this.message,
        this.pendingPmRequest,
        this.preventiveRequests});

  CreatePreventiveCalender.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    warrantyDate = json['warranty_date'];
    message = json['message'];
    pendingPmRequest = json['pending_pm_request'];
    if (json['preventive_requests'] != null) {
      preventiveRequests = <PreventiveRequests>[];
      json['preventive_requests'].forEach((v) {
        preventiveRequests!.add(new PreventiveRequests.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['warranty_date'] = this.warrantyDate;
    data['message'] = this.message;
    data['pending_pm_request'] = this.pendingPmRequest;
    if (this.preventiveRequests != null) {
      data['preventive_requests'] =
          this.preventiveRequests!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PreventiveRequests {
  String? warrantyId;
  String? serviceId;
  String? serviceNo;
  String? warrantyDate;
  String? itemNo;
  String? itemName;
  String? serialNo;
  String? customerNo;
  String? customerName;
  String? customerAddress;
  String? customerPincode;


  PreventiveRequests(
      {this.warrantyId,
        this.serviceId,
        this.serviceNo,
        this.warrantyDate,
        this.itemNo,
        this.itemName,
        this.serialNo,
        this.customerNo,
        this.customerName,
        this.customerAddress,
        this.customerPincode});

  PreventiveRequests.fromJson(Map<String, dynamic> json) {
    warrantyId = json['warranty_id'];
    serviceId = json['service_id'];
    serviceNo = json['service_no'];
    warrantyDate = json['warranty_date'];
    itemNo = json['item_no'];
    itemName = json['item_name'];
    serialNo = json['serial_no'];
    customerNo = json['customer_no'];
    customerName = json['customer_name'];
    customerAddress = json['customer_address'];
    customerPincode = json['customer_pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warranty_id'] = this.warrantyId;
    data['service_id'] = this.serviceId;
    data['service_no'] = this.serviceNo;
    data['warranty_date'] = this.warrantyDate;
    data['item_no'] = this.itemNo;
    data['item_name'] = this.itemName;
    data['serial_no'] = this.serialNo;
    data['customer_no'] = this.customerNo;
    data['customer_name'] = this.customerName;
    data['customer_address'] = this.customerAddress;
    data['customer_pincode'] = this.customerPincode;
    return data;
  }
}