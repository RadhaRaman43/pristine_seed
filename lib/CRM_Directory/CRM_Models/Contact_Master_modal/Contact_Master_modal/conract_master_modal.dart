class ContactMstGetListModal {
  String? condition;
  String? message;
  String? totalRows;
  String? contactCode;
  String? contactName;
  String? contactTitle;
  String? accountCode;
  String? accountName;
  String? emailId;
  String? phoneNo;
  String? alternateNo;
  String? departmentCode;
  String? departmentName;
  String? designationcode;
  String? designationname;
  String? reportingPerson;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;
  int? isDecisionMaker;

  ContactMstGetListModal(
      {this.condition,
        this.message,
        this.totalRows,
        this.contactCode,
        this.contactName,
        this.contactTitle,
        this.accountCode,
        this.accountName,
        this.emailId,
        this.phoneNo,
        this.alternateNo,
        this.departmentCode,
        this.departmentName,
        this.designationcode,
        this.designationname,
        this.reportingPerson,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
        this.isDecisionMaker});

  ContactMstGetListModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    totalRows = json['total_rows'];
    contactCode = json['contact_code'];
    contactName = json['contact_name'];
    contactTitle = json['contact_title'];
    accountCode = json['account_code'];
    accountName = json['account_name'];
    emailId = json['email_id'];
    phoneNo = json['phone_no'];
    alternateNo = json['alternate_no'];
    departmentCode = json['department_code'];
    departmentName = json['department_name'];
    designationcode = json['designation_code'];
    designationname = json['designation_name'];
    reportingPerson = json['reporting_person'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
    isDecisionMaker = json['is_decision_maker'];
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
    data['email_id'] = this.emailId;
    data['phone_no'] = this.phoneNo;
    data['alternate_no'] = this.alternateNo;
    data['department_code'] = this.departmentCode;
    data['department_name'] = this.departmentName;
    data['designation_code'] = designationcode;
    data['designation_name'] = designationname;
    data['reporting_person'] = this.reportingPerson;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    data['is_decision_maker'] = this.isDecisionMaker;
    return data;
  }
}