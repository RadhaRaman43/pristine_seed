class OrderHeaderGetModel {
  String? condition;
  String? totalRows;
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
  double? totalDiscountAmt;
  int? totalApproveQty;
  double? totalApprovePrice;
  double? totalApproveDiscountAmt;
  String? orderStatus;
  String? description;
  String? createdBy;
  String? createdOn;
  String? completedOn;
  String? rejectReason;
  String? approveBy;
  String? approveOn;
  int? isShipment;
  String? shipmentOn;
  int? isDistributorOrder;
  String? bulkOrderCreatedBy;
  int? isBulkOrder;
  double? pendingAmount;
  double? underApproveAmount;
  double? pendingShipmentAmount;

  OrderHeaderGetModel(
      {this.condition,
        this.totalRows,
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
        this.totalDiscountAmt,
        this.totalApproveQty,
        this.totalApprovePrice,
        this.totalApproveDiscountAmt,
        this.orderStatus,
        this.description,
        this.createdBy,
        this.createdOn,
        this.completedOn,
        this.rejectReason,
        this.approveBy,
        this.approveOn,
        this.isShipment,
        this.shipmentOn,
        this.isDistributorOrder,
        this.bulkOrderCreatedBy,
        this.isBulkOrder,
        this.pendingAmount,
        this.underApproveAmount,
        this.pendingShipmentAmount});

  OrderHeaderGetModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
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
    totalDiscountAmt = json['total_discount_amt'];
    totalApproveQty = json['total_approve_qty'];
    totalApprovePrice = json['total_approve_price'];
    totalApproveDiscountAmt = json['total_approve_discount_amt'];
    orderStatus = json['order_status'];
    description = json['description'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    completedOn = json['completed_on'];
    rejectReason = json['reject_reason'];
    approveBy = json['approve_by'];
    approveOn = json['approve_on'];
    isShipment = json['is_shipment'];
    shipmentOn = json['shipment_on'];
    isDistributorOrder = json['is_distributor_order'];
    bulkOrderCreatedBy = json['bulk_order_created_by'];
    isBulkOrder = json['is_bulk_order'];
    pendingAmount = json['pending_amount'];
    underApproveAmount = json['under_approve_amount'];
    pendingShipmentAmount = json['pending_shipment_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
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
    data['total_discount_amt'] = this.totalDiscountAmt;
    data['total_approve_qty'] = this.totalApproveQty;
    data['total_approve_price'] = this.totalApprovePrice;
    data['total_approve_discount_amt'] = this.totalApproveDiscountAmt;
    data['order_status'] = this.orderStatus;
    data['description'] = this.description;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['completed_on'] = this.completedOn;
    data['reject_reason'] = this.rejectReason;
    data['approve_by'] = this.approveBy;
    data['approve_on'] = this.approveOn;
    data['is_shipment'] = this.isShipment;
    data['shipment_on'] = this.shipmentOn;
    data['is_distributor_order'] = this.isDistributorOrder;
    data['bulk_order_created_by'] = this.bulkOrderCreatedBy;
    data['is_bulk_order'] = this.isBulkOrder;
    data['pending_amount'] = this.pendingAmount;
    data['under_approve_amount'] = this.underApproveAmount;
    data['pending_shipment_amount'] = this.pendingShipmentAmount;
    return data;
  }
}