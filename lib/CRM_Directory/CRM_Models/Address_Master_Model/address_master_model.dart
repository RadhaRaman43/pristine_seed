class AddressMasterModel{
  String? condition;
  String? message;
  String? totalRows;
  String? consigneeId;
  String? accountCode;
  String? accountName;
  String? contactName;
  String? phoneNo;
  String? emailId;
  String? address;
  String? address2;
  String? postCode;
  String? stateCode;
  String? stateName;
  String? city;
  String? district;
  String? panNo;
  String? gstType;
  String? gstNo;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;
  String? alternateNo;
  String? ifscCode;
  String? navConsigneeCode;

  AddressMasterModel(
      {this.condition,
        this.message,
        this.totalRows,
        this.consigneeId,
        this.accountCode,
        this.accountName,
        this.contactName,
        this.phoneNo,
        this.emailId,
        this.address,
        this.address2,
        this.postCode,
        this.stateCode,
        this.stateName,
        this.city,
        this.district,
        this.panNo,
        this.gstType,
        this.gstNo,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
        this.alternateNo,
        this.ifscCode,
        this.navConsigneeCode});

  AddressMasterModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    totalRows = json['total_rows'];
    consigneeId = json['consignee_id'];
    accountCode = json['account_code'];
    accountName = json['account_name'];
    contactName = json['contact_name'];
    phoneNo = json['phone_no'];
    emailId = json['email_id'];
    address = json['address'];
    address2 = json['address2'];
    postCode = json['post_code'];
    stateCode = json['state_code'];
    stateName = json['state_name'];
    city = json['city'];
    district = json['district'];
    panNo = json['pan_no'];
    gstType = json['gst_type'];
    gstNo = json['gst_no'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
    alternateNo = json['alternate_no'];
    ifscCode = json['ifsc_code'];
    navConsigneeCode = json['nav_consignee_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['total_rows'] = this.totalRows;
    data['consignee_id'] = this.consigneeId;
    data['account_code'] = this.accountCode;
    data['account_name'] = this.accountName;
    data['contact_name'] = this.contactName;
    data['phone_no'] = this.phoneNo;
    data['email_id'] = this.emailId;
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['post_code'] = this.postCode;
    data['state_code'] = this.stateCode;
    data['state_name'] = this.stateName;
    data['city'] = this.city;
    data['district'] = this.district;
    data['pan_no'] = this.panNo;
    data['gst_type'] = this.gstType;
    data['gst_no'] = this.gstNo;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    data['alternate_no'] = this.alternateNo;
    data['ifsc_code'] = this.ifscCode;
    data['nav_consignee_code'] = this.navConsigneeCode;
    return data;
  }
}