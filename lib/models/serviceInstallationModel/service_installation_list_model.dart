

class ServiceInstallationListResponse {
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
  String? parentServiceId;
  int? isAssignment;
  String? assignedPersonEmail;
  String? assignedReasonCode;
  String? assignedReasonDesc;
  String? assignedRemark;
  String? updatedBy;
  String? updatedOn;
  String? rescheduleDatetime;
  String? rescheduleReasonCode;
  String? rescheduleReasonDesc;
  String? rescheduleRemark;
  String? complainReasonCode;
  String? complainReasonDesc;
  String? complainRemark;
  String? reopenRemark;
  String? completeRemark;
  int? isWarrantyReceive;
  String? warrantyStartDate;
  String? warrantyEndDate;
  int? frequencyOfPm;
  String? serviceTatDatetime;
  double? visitCharges;
  String? fromLatitude;
  String? fromLongitude;
  String? completedOn;
  int? isUnderApproval;
  String? completeApprovalStatus;
  String? completeApprovalBy;
  String? completeApprovalOn;
  String? completeApprovalRemark;
  String? recheduleApprovalStatus;
  String? recheduleApprovalBy;
  String? recheduleApprovalOn;
  String? recheduleApprovalRemark;

  ServiceInstallationListResponse(
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
        this.parentServiceId,
        this.isAssignment,
        this.assignedPersonEmail,
        this.assignedReasonCode,
        this.assignedReasonDesc,
        this.assignedRemark,
        this.updatedBy,
        this.updatedOn,
        this.rescheduleDatetime,
        this.rescheduleReasonCode,
        this.rescheduleReasonDesc,
        this.rescheduleRemark,
        this.complainReasonCode,
        this.complainReasonDesc,
        this.complainRemark,
        this.reopenRemark,
        this.completeRemark,
        this.isWarrantyReceive,
        this.warrantyStartDate,
        this.warrantyEndDate,
        this.frequencyOfPm,
        this.serviceTatDatetime,
        this.visitCharges,
        this.fromLatitude,
        this.fromLongitude,
        this.completedOn,
        this.isUnderApproval,
        this.completeApprovalStatus,
        this.completeApprovalBy,
        this.completeApprovalOn,
        this.completeApprovalRemark,
        this.recheduleApprovalStatus,
        this.recheduleApprovalBy,
        this.recheduleApprovalOn,
        this.recheduleApprovalRemark});

  ServiceInstallationListResponse.fromJson(Map<String, dynamic> json) {
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
    parentServiceId = json['parent_service_id'];
    isAssignment = json['is_assignment'];
    assignedPersonEmail = json['assigned_person_email'];
    assignedReasonCode = json['assigned_reason_code'];
    assignedReasonDesc = json['assigned_reason_desc'];
    assignedRemark = json['assigned_remark'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
    rescheduleDatetime = json['reschedule_datetime'];
    rescheduleReasonCode = json['reschedule_reason_code'];
    rescheduleReasonDesc = json['reschedule_reason_desc'];
    rescheduleRemark = json['reschedule_remark'];
    complainReasonCode = json['complain_reason_code'];
    complainReasonDesc = json['complain_reason_desc'];
    complainRemark = json['complain_remark'];
    reopenRemark = json['reopen_remark'];
    completeRemark = json['complete_remark'];
    isWarrantyReceive = json['is_warranty_receive'];
    warrantyStartDate = json['warranty_start_date'];
    warrantyEndDate = json['warranty_end_date'];
    frequencyOfPm = json['frequency_of_pm'];
    serviceTatDatetime = json['service_tat_datetime'];
    visitCharges = json['visit_charges'];
    fromLatitude = json['from_latitude'];
    fromLongitude = json['from_longitude'];
    completedOn = json['completed_on'];
    isUnderApproval = json['is_under_approval'];
    completeApprovalStatus = json['complete_approval_status'];
    completeApprovalBy = json['complete_approval_by'];
    completeApprovalOn = json['complete_approval_on'];
    completeApprovalRemark = json['complete_approval_remark'];
    recheduleApprovalStatus = json['rechedule_approval_status'];
    recheduleApprovalBy = json['rechedule_approval_by'];
    recheduleApprovalOn = json['rechedule_approval_on'];
    recheduleApprovalRemark = json['rechedule_approval_remark'];
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
    data['parent_service_id'] = this.parentServiceId;
    data['is_assignment'] = this.isAssignment;
    data['assigned_person_email'] = this.assignedPersonEmail;
    data['assigned_reason_code'] = this.assignedReasonCode;
    data['assigned_reason_desc'] = this.assignedReasonDesc;
    data['assigned_remark'] = this.assignedRemark;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    data['reschedule_datetime'] = this.rescheduleDatetime;
    data['reschedule_reason_code'] = this.rescheduleReasonCode;
    data['reschedule_reason_desc'] = this.rescheduleReasonDesc;
    data['reschedule_remark'] = this.rescheduleRemark;
    data['complain_reason_code'] = this.complainReasonCode;
    data['complain_reason_desc'] = this.complainReasonDesc;
    data['complain_remark'] = this.complainRemark;
    data['reopen_remark'] = this.reopenRemark;
    data['complete_remark'] = this.completeRemark;
    data['is_warranty_receive'] = this.isWarrantyReceive;
    data['warranty_start_date'] = this.warrantyStartDate;
    data['warranty_end_date'] = this.warrantyEndDate;
    data['frequency_of_pm'] = this.frequencyOfPm;
    data['service_tat_datetime'] = this.serviceTatDatetime;
    data['visit_charges'] = this.visitCharges;
    data['from_latitude'] = this.fromLatitude;
    data['from_longitude'] = this.fromLongitude;
    data['completed_on'] = this.completedOn;
    data['is_under_approval'] = this.isUnderApproval;
    data['complete_approval_status'] = this.completeApprovalStatus;
    data['complete_approval_by'] = this.completeApprovalBy;
    data['complete_approval_on'] = this.completeApprovalOn;
    data['complete_approval_remark'] = this.completeApprovalRemark;
    data['rechedule_approval_status'] = this.recheduleApprovalStatus;
    data['rechedule_approval_by'] = this.recheduleApprovalBy;
    data['rechedule_approval_on'] = this.recheduleApprovalOn;
    data['rechedule_approval_remark'] = this.recheduleApprovalRemark;
    return data;
  }
}