class AccountMasterModel {
  int? id;
  String? condition;
  String? totalRows;
  String? accountCode;
  String? accountName;
  String? accountOwner;
  String? accountTitle;
  String? accountType;
  String? referralBy;
  String? phoneNo;
  String? emailId;
  String? accountCategoryType;
  String? companyProfileType;
  String? companyProfileSubType;
  String? companyProfileRemark;
  PermanentAddress? permanentAddress;
  int? noOfEmployees;
  double? annualRevenue;
  String? tatResponseType;
  int? tatResponseTime;
  String? salesRepresentative;
  String? regionalServiceHead;
  String? profile;
  int? isActive;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;
  int? isManager;
  String? gstType;
  String? gstNo;
  String? panNo;

  AccountMasterModel(
      {this.id,
        this.condition,
        this.totalRows,
        this.accountCode,
        this.accountName,
        this.accountOwner,
        this.accountTitle,
        this.accountType,
        this.referralBy,
        this.phoneNo,
        this.emailId,
        this.accountCategoryType,
        this.companyProfileType,
        this.companyProfileSubType,
        this.companyProfileRemark,
        this.permanentAddress,
        this.noOfEmployees,
        this.annualRevenue,
        this.tatResponseType,
        this.tatResponseTime,
        this.salesRepresentative,
        this.regionalServiceHead,
        this.profile,
        this.isActive,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
        this.isManager,
        this.gstType,
        this.gstNo,
        this.panNo});

  AccountMasterModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    condition = json['condition'];
    totalRows = json['total_rows'];
    accountCode = json['account_code'];
    accountName = json['account_name'];
    accountOwner = json['account_owner'];
    accountTitle = json['account_title'];
    accountType = json['account_type'];
    referralBy = json['referral_by'];
    phoneNo = json['phone_no'];
    emailId = json['email_id'];
    accountCategoryType = json['account_category_type'];
    companyProfileType = json['company_profile_type'];
    companyProfileSubType = json['company_profile_sub_type'];
    companyProfileRemark = json['company_profile_remark'];
    permanentAddress = json['PermanentAddress'] != null
        ? new PermanentAddress.fromJson(json['PermanentAddress'])
        : null;
    noOfEmployees = json['no_of_employees'];
    annualRevenue = json['annual_revenue'];
    tatResponseType = json['tat_response_type'];
    tatResponseTime = json['tat_response_time'];
    salesRepresentative = json['sales_representative'];
    regionalServiceHead = json['regional_service_head'];
    profile = json['profile'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
    isManager = json['is_manager'];
    gstType = json['gst_type'];
    gstNo = json['gst_no'];
    panNo = json['pan_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
   // data['id'] = this.id;
    data['total_rows'] = this.totalRows;
    data['account_code'] = this.accountCode;
    data['account_name'] = this.accountName;
    data['account_owner'] = this.accountOwner;
    data['account_title'] = this.accountTitle;
    data['account_type'] = this.accountType;
    data['referral_by'] = this.referralBy;
    data['phone_no'] = this.phoneNo;
    data['email_id'] = this.emailId;
    data['account_category_type'] = this.accountCategoryType;
    data['company_profile_type'] = this.companyProfileType;
    data['company_profile_sub_type'] = this.companyProfileSubType;
    data['company_profile_remark'] = this.companyProfileRemark;
    if (this.permanentAddress != null) {
      data['PermanentAddress'] = this.permanentAddress!.toJson();
    }
    data['no_of_employees'] = this.noOfEmployees;
    data['annual_revenue'] = this.annualRevenue;
    data['tat_response_type'] = this.tatResponseType;
    data['tat_response_time'] = this.tatResponseTime;
    data['sales_representative'] = this.salesRepresentative;
    data['regional_service_head'] = this.regionalServiceHead;
    data['profile'] = this.profile;
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    data['is_manager'] = this.isManager;
    data['gst_type'] = this.gstType;
    data['gst_no'] = this.gstNo;
    data['pan_no'] = this.panNo;
    return data;
  }
}

class PermanentAddress {
  String? address;
  String? address2;
  String? postCode;
  String? stateCode;
  String? stateName;
  String? countryCode;
  String? countryName;
  String? city;
  String? district;

  PermanentAddress(
      {this.address,
        this.address2,
        this.postCode,
        this.stateCode,
        this.stateName,
        this.countryCode,
        this.countryName,
        this.city,
        this.district});

  PermanentAddress.fromJson(Map<String, dynamic> json) {
    address = json['Address'];
    address2 = json['Address2'];
    postCode = json['PostCode'];
    stateCode = json['StateCode'];
    stateName = json['StateName'];
    countryCode = json['CountryCode'];
    countryName = json['CountryName'];
    city = json['City'];
    district = json['District'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Address'] = this.address;
    data['Address2'] = this.address2;
    data['PostCode'] = this.postCode;
    data['StateCode'] = this.stateCode;
    data['StateName'] = this.stateName;
    data['CountryCode'] = this.countryCode;
    data['CountryName'] = this.countryName;
    data['City'] = this.city;
    data['District'] = this.district;
    return data;
  }
}