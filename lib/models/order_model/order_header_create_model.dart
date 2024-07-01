class OrderHeaderCreateModel {
  String? condition;
  String? message;
  String? orderNo;
  String? orderDate;
  String? expiryDate;
  String? customerNo;
  String? customerName;
  String? customerAddress;
  String? customerStateCode;
  String? customerStateName;
  String? customerCountryName;
  String? customerPostalCode;
  String? customerPhoneNo;
  String? customerGstRegistrationNo;
  int? totalQty;
  double? totalPrice;
  int? totalApproveQty;
  double? totalApprovePrice;
  String? orderStatus;
  String? description;
  String? createdBy;
  String? createdOn;
  String? completedOn;
  String? rejectReason;
  String? approveBy;
  String? approveOn;
  String? captionForCategory;
  double? totalDiscountAmt;
  double? totalApproveDiscountAmt;
  List<Lines>? lines;

  OrderHeaderCreateModel(
      {this.condition,
        this.message,
        this.orderNo,
        this.orderDate,
        this.expiryDate,
        this.customerNo,
        this.customerName,
        this.customerAddress,
        this.customerStateCode,
        this.customerStateName,
        this.customerCountryName,
        this.customerPostalCode,
        this.customerPhoneNo,
        this.customerGstRegistrationNo,
        this.totalQty,
        this.totalPrice,
        this.totalApproveQty,
        this.totalApprovePrice,
        this.orderStatus,
        this.description,
        this.createdBy,
        this.createdOn,
        this.completedOn,
        this.rejectReason,
        this.approveBy,
        this.approveOn,
        this.captionForCategory,
        this.totalDiscountAmt,
        this.totalApproveDiscountAmt,
        this.lines});

  OrderHeaderCreateModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    orderNo = json['order_no'];
    orderDate = json['order_date'];
    expiryDate = json['expiry_date'];
    customerNo = json['customer_no'];
    customerName = json['customer_name'];
    customerAddress = json['customer_address'];
    customerStateCode = json['customer_state_code'];
    customerStateName = json['customer_state_name'];
    customerCountryName = json['customer_country_name'];
    customerPostalCode = json['customer_postal_code'];
    customerPhoneNo = json['customer_phone_no'];
    customerGstRegistrationNo = json['customer_gst_registration_no'];
    totalQty = json['total_qty'];
    totalPrice = json['total_price'];
    totalApproveQty = json['total_approve_qty'];
    totalApprovePrice = json['total_approve_price'];
    orderStatus = json['order_status'];
    description = json['description'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    completedOn = json['completed_on'];
    rejectReason = json['reject_reason'];
    approveBy = json['approve_by'];
    approveOn = json['approve_on'];
    captionForCategory = json['caption_for_category'];
    totalDiscountAmt = json['total_discount_amt'];
    totalApproveDiscountAmt = json['total_approve_discount_amt'];
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
    data['order_no'] = this.orderNo;
    data['order_date'] = this.orderDate;
    data['expiry_date'] = this.expiryDate;
    data['customer_no'] = this.customerNo;
    data['customer_name'] = this.customerName;
    data['customer_address'] = this.customerAddress;
    data['customer_state_code'] = this.customerStateCode;
    data['customer_state_name'] = this.customerStateName;
    data['customer_country_name'] = this.customerCountryName;
    data['customer_postal_code'] = this.customerPostalCode;
    data['customer_phone_no'] = this.customerPhoneNo;
    data['customer_gst_registration_no'] = this.customerGstRegistrationNo;
    data['total_qty'] = this.totalQty;
    data['total_price'] = this.totalPrice;
    data['total_approve_qty'] = this.totalApproveQty;
    data['total_approve_price'] = this.totalApprovePrice;
    data['order_status'] = this.orderStatus;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['completed_on'] = this.completedOn;
    data['reject_reason'] = this.rejectReason;
    data['approve_by'] = this.approveBy;
    data['approve_on'] = this.approveOn;
    data['caption_for_category'] = this.captionForCategory;
    data['total_discount_amt'] = this.totalDiscountAmt;
    data['total_approve_discount_amt'] = this.totalApproveDiscountAmt;
    if (this.lines != null) {
      data['lines'] = this.lines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Lines {
  String? orderNo;
  String? itemNo;
  int? qty;
  double? unitPrice;
  double? totalPrice;
  int? approveQty;
  double? approvePrice;
  String? updatedOn;
  double? discountAmt;
  double? discountPer;
  double? approveDiscountAmt;
  String? baseUnitOfMeasure;
  String? imageUrl;

  Lines(
      {this.orderNo,
        this.itemNo,
        this.qty,
        this.unitPrice,
        this.totalPrice,
        this.approveQty,
        this.approvePrice,
        this.updatedOn,
        this.discountAmt,
        this.discountPer,
        this.approveDiscountAmt,
        this.baseUnitOfMeasure,
        this.imageUrl});

  Lines.fromJson(Map<String, dynamic> json) {
    orderNo = json['order_no'];
    itemNo = json['item_no'];
    qty = json['qty'];
    unitPrice = json['unit_price'];
    totalPrice = json['total_price'];
    approveQty = json['approve_qty'];
    approvePrice = json['approve_price'];
    updatedOn = json['updated_on'];
    discountAmt = json['discount_amt'];
    discountPer = json['discount_per'];
    approveDiscountAmt = json['approve_discount_amt'];
    baseUnitOfMeasure = json['base_unit_of_measure'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_no'] = this.orderNo;
    data['item_no'] = this.itemNo;
    data['qty'] = this.qty;
    data['unit_price'] = this.unitPrice;
    data['total_price'] = this.totalPrice;
    data['approve_qty'] = this.approveQty;
    data['approve_price'] = this.approvePrice;
    data['updated_on'] = this.updatedOn;
    data['discount_amt'] = this.discountAmt;
    data['discount_per'] = this.discountPer;
    data['approve_discount_amt'] = this.approveDiscountAmt;
    data['base_unit_of_measure'] = this.baseUnitOfMeasure;
    data['image_url'] = this.imageUrl;
    return data;
  }
}