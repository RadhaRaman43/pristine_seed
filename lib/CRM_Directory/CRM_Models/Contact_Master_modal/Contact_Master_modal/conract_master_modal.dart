class ContactMstGetListModal {
  String? condition;
  String? message;
  String? totalRows;
  String? contactCode;
  String? contactName;
  String? contactTitle;
  String? accountCode;
  String? accountName;
  String? fullAddress;
  String? emailId;
  String? phoneNo;
  String? alternateNo;
  String? departmentCode;
  String? departmentName;
  String? designationCode;
  String? designationName;
  String? reportingPerson;
  String? createdBy;
  String? createdOn;
  String? createdFullName;
  String? updatedBy;
  String? updatedOn;
  String? contactRole;

  ContactMstGetListModal(
      {this.condition,
        this.message,
        this.totalRows,
        this.contactCode,
        this.contactName,
        this.contactTitle,
        this.accountCode,
        this.accountName,
        this.fullAddress,
        this.emailId,
        this.phoneNo,
        this.alternateNo,
        this.departmentCode,
        this.departmentName,
        this.designationCode,
        this.designationName,
        this.reportingPerson,
        this.createdBy,
        this.createdOn,
        this.createdFullName,
        this.updatedBy,
        this.updatedOn,
        this.contactRole});

  ContactMstGetListModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    totalRows = json['total_rows'];
    contactCode = json['contact_code'];
    contactName = json['contact_name'];
    contactTitle = json['contact_title'];
    accountCode = json['account_code'];
    accountName = json['account_name'];
    fullAddress = json['full_address'];
    emailId = json['email_id'];
    phoneNo = json['phone_no'];
    alternateNo = json['alternate_no'];
    departmentCode = json['department_code'];
    departmentName = json['department_name'];
    designationCode = json['designation_code'];
    designationName = json['designation_name'];
    reportingPerson = json['reporting_person'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    createdFullName = json['created_full_name'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
    contactRole = json['contact_role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['total_rows'] = this.totalRows;
    data['contact_code'] = this.contactCode;
    data['contact_name'] = this.contactName;
    data['contact_title'] = this.contactTitle;
    data['account_code'] = this.accountCode;
    data['account_name'] = this.accountName;
    data['full_address'] = this.fullAddress;
    data['email_id'] = this.emailId;
    data['phone_no'] = this.phoneNo;
    data['alternate_no'] = this.alternateNo;
    data['department_code'] = this.departmentCode;
    data['department_name'] = this.departmentName;
    data['designation_code'] = this.designationCode;
    data['designation_name'] = this.designationName;
    data['reporting_person'] = this.reportingPerson;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['created_full_name'] = this.createdFullName;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    data['contact_role'] = this.contactRole;
    return data;
  }
}