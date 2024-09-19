class OrderApprovalModel {
  String? condition;
  String? message;
  String? documentType;
  String? pendingCount;
  String? approvedCount;
  String? rejectedCount;
  String? imageUrl;
  String? orderNo;
  String? orderDate;
  String? expiryDate;
  String? customerNo;
  String? customerName;
  String? customerAddress;
  String? customerStateCode;
  String? customerGstRegistrationNo;
  String? consigneeId;
  String? consigneeName;
  String? consigneeAddress;
  String? consigneeStateCode;
  String? consigneeGstRegistrationNo;
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
  double? totalApproveDiscountAmt;

  OrderApprovalModel(
      {this.condition,
        this.message,
        this.documentType,
        this.pendingCount,
        this.approvedCount,
        this.rejectedCount,
        this.imageUrl,
        this.orderNo,
        this.orderDate,
        this.expiryDate,
        this.customerNo,
        this.customerName,
        this.customerAddress,
        this.customerStateCode,
        this.customerGstRegistrationNo,
        this.consigneeId,
        this.consigneeName,
        this.consigneeAddress,
        this.consigneeStateCode,
        this.consigneeGstRegistrationNo,
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
        this.totalApproveDiscountAmt});

  OrderApprovalModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    documentType = json['document_type'];
    pendingCount = json['pending_count'];
    approvedCount = json['approved_count'];
    rejectedCount = json['rejected_count'];
    imageUrl = json['image_url'];
    orderNo = json['order_no'];
    orderDate = json['order_date'];
    expiryDate = json['expiry_date'];
    customerNo = json['customer_no'];
    customerName = json['customer_name'];
    customerAddress = json['customer_address'];
    customerStateCode = json['customer_state_code'];
    customerGstRegistrationNo = json['customer_gst_registration_no'];
    consigneeId = json['consignee_id'];
    consigneeName = json['consignee_name'];
    consigneeAddress = json['consignee_address'];
    consigneeStateCode = json['consignee_state_code'];
    consigneeGstRegistrationNo = json['consignee_gst_registration_no'];
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
    totalApproveDiscountAmt = json['total_approve_discount_amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['document_type'] = this.documentType;
    data['pending_count'] = this.pendingCount;
    data['approved_count'] = this.approvedCount;
    data['rejected_count'] = this.rejectedCount;
    data['image_url'] = this.imageUrl;
    data['order_no'] = this.orderNo;
    data['order_date'] = this.orderDate;
    data['expiry_date'] = this.expiryDate;
    data['customer_no'] = this.customerNo;
    data['customer_name'] = this.customerName;
    data['customer_address'] = this.customerAddress;
    data['customer_state_code'] = this.customerStateCode;
    data['customer_gst_registration_no'] = this.customerGstRegistrationNo;
    data['consignee_id'] = this.consigneeId;
    data['consignee_name'] = this.consigneeName;
    data['consignee_address'] = this.consigneeAddress;
    data['consignee_state_code'] = this.consigneeStateCode;
    data['consignee_gst_registration_no'] = this.consigneeGstRegistrationNo;
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
    data['total_approve_discount_amt'] = this.totalApproveDiscountAmt;
    return data;
  }
}