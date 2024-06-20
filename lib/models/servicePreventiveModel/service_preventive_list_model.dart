class ServicePreventiveListResponse {
  String? condition;
  int? totalCount;
  int? id;
  String? serviceNo;
  int? lineNo;
  String? serviceType;
  String? invoiceNo;
  String? invoiceDate;
  String? customerNo;
  String? customerName;
  String? customerAddress;
  String? customerPincode;
  String? customerState;
  String? customerStateCode;
  String? contactPerson;
  String? customerPhoneNo;
  String? customerIfscCode;
  String? customerEmailId;
  String? itemNo;
  String? itemName;
  String? serialNo;
  String? salesDate;
  String? deliveryDateTime;
  String? serviceItemCardNo;
  String? createdBy;
  String? createdOn;
  String? serviceStatus;
  String? parentServiceNo;
  int? isAssignment;
  String? assignedPersonEmail;
  String? assignedReasonCode;
  String? assignedReasonDesc;
  String? assignedRemark;
  String? serviceTatDatetime;
  String? updatedBy;
  String? updatedOn;

  ServicePreventiveListResponse(
      {this.condition,
        this.totalCount,
        this.id,
        this.serviceNo,
        this.lineNo,
        this.serviceType,
        this.invoiceNo,
        this.invoiceDate,
        this.customerNo,
        this.customerName,
        this.customerAddress,
        this.customerPincode,
        this.customerState,
        this.customerStateCode,
        this.contactPerson,
        this.customerPhoneNo,
        this.customerIfscCode,
        this.customerEmailId,
        this.itemNo,
        this.itemName,
        this.serialNo,
        this.salesDate,
        this.deliveryDateTime,
        this.serviceItemCardNo,
        this.createdBy,
        this.createdOn,
        this.serviceStatus,
        this.parentServiceNo,
        this.isAssignment,
        this.assignedPersonEmail,
        this.assignedReasonCode,
        this.assignedReasonDesc,
        this.assignedRemark,
        this.serviceTatDatetime,
        this.updatedBy,
        this.updatedOn});

  ServicePreventiveListResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalCount = json['total_count'];
    id = json['id'];
    serviceNo = json['service_no'];
    lineNo = json['line_no'];
    serviceType = json['service_type'];
    invoiceNo = json['invoice_no'];
    invoiceDate = json['invoice_date'];
    customerNo = json['customer_no'];
    customerName = json['customer_name'];
    customerAddress = json['customer_address'];
    customerPincode = json['customer_pincode'];
    customerState = json['customer_state'];
    customerStateCode = json['customer_state_code'];
    contactPerson = json['contact_person'];
    customerPhoneNo = json['customer_phone_no'];
    customerIfscCode = json['customer_ifsc_code'];
    customerEmailId = json['customer_email_id'];
    itemNo = json['item_no'];
    itemName = json['item_name'];
    serialNo = json['serial_no'];
    salesDate = json['sales_date'];
    deliveryDateTime = json['delivery_date_time'];
    serviceItemCardNo = json['service_item_card_no'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    serviceStatus = json['service_status'];
    parentServiceNo = json['parent_service_no'];
    isAssignment = json['is_assignment'];
    assignedPersonEmail = json['assigned_person_email'];
    assignedReasonCode = json['assigned_reason_code'];
    assignedReasonDesc = json['assigned_reason_desc'];
    assignedRemark = json['assigned_remark'];
    serviceTatDatetime = json['service_tat_datetime'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_count'] = this.totalCount;
    data['id'] = this.id;
    data['service_no'] = this.serviceNo;
    data['line_no'] = this.lineNo;
    data['service_type'] = this.serviceType;
    data['invoice_no'] = this.invoiceNo;
    data['invoice_date'] = this.invoiceDate;
    data['customer_no'] = this.customerNo;
    data['customer_name'] = this.customerName;
    data['customer_address'] = this.customerAddress;
    data['customer_pincode'] = this.customerPincode;
    data['customer_state'] = this.customerState;
    data['customer_state_code'] = this.customerStateCode;
    data['contact_person'] = this.contactPerson;
    data['customer_phone_no'] = this.customerPhoneNo;
    data['customer_ifsc_code'] = this.customerIfscCode;
    data['customer_email_id'] = this.customerEmailId;
    data['item_no'] = this.itemNo;
    data['item_name'] = this.itemName;
    data['serial_no'] = this.serialNo;
    data['sales_date'] = this.salesDate;
    data['delivery_date_time'] = this.deliveryDateTime;
    data['service_item_card_no'] = this.serviceItemCardNo;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['service_status'] = this.serviceStatus;
    data['parent_service_no'] = this.parentServiceNo;
    data['is_assignment'] = this.isAssignment;
    data['assigned_person_email'] = this.assignedPersonEmail;
    data['assigned_reason_code'] = this.assignedReasonCode;
    data['assigned_reason_desc'] = this.assignedReasonDesc;
    data['assigned_remark'] = this.assignedRemark;
    data['service_tat_datetime'] = this.serviceTatDatetime;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    return data;
  }
}