class AccountMasterGetByCodeModel {
  String? condition;
  String? message;
  String? totalRows;
  String? accountCode;
  String? accountName;
  String? accountCreateFullName;
  String? accountOwner;
  String? accountOwnerFullName;
  String? accountTitle;
  String? accountType;
  String? referralBy;
  String? phoneNo;
  String? emailId;
  String? accountCategoryType;
  String? companyProfileType;
  String? companyProfileSubType;
  String? companyProfileRemark;
  String? stateCode;
  String? stateName;
  String? postCode;
  PermanentAddress? permanentAddress;
  int? noOfEmployees;
  double? annualRevenue;
  String? tatResponseType;
  int? tatResponseTime;
  String? salesRepresentative;
  String? regionalServiceHead;
  String? salesRepresentativeName;
  String? regionalServiceHeadName;
  String? profile;
  int? isActive;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;
  String? gstType;
  String? gstNo;
  String? panNo;
  String? ifscCode;
  String? shippingAddress;
  String? shippingAddress2;
  String? shippingCity;
  String? shippingDistrict;
  String? shippingPostCode;
  String? shippingStateCode;
  String? shippingStateName;
  int? isReferral;
  String? frontlinerValue;
  String? branchHeadValue;
  String? zoneHeadValue;
  String? clustureHeadValue;
  int? isAccountFixed;
  String? oldCrmAccountNo;

  AccountMasterGetByCodeModel(
      {this.condition,
        this.message,
        this.totalRows,
        this.accountCode,
        this.accountName,
        this.accountCreateFullName,
        this.accountOwner,
        this.accountOwnerFullName,
        this.accountTitle,
        this.accountType,
        this.referralBy,
        this.phoneNo,
        this.emailId,
        this.accountCategoryType,
        this.companyProfileType,
        this.companyProfileSubType,
        this.companyProfileRemark,
        this.stateCode,
        this.stateName,
        this.postCode,
        this.permanentAddress,
        this.noOfEmployees,
        this.annualRevenue,
        this.tatResponseType,
        this.tatResponseTime,
        this.salesRepresentative,
        this.regionalServiceHead,
        this.salesRepresentativeName,
        this.regionalServiceHeadName,
        this.profile,
        this.isActive,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
        this.gstType,
        this.gstNo,
        this.panNo,
        this.ifscCode,
        this.shippingAddress,
        this.shippingAddress2,
        this.shippingCity,
        this.shippingDistrict,
        this.shippingPostCode,
        this.shippingStateCode,
        this.shippingStateName,
        this.isReferral,
        this.frontlinerValue,
        this.branchHeadValue,
        this.zoneHeadValue,
        this.clustureHeadValue,
        this.isAccountFixed,
        this.oldCrmAccountNo});

  AccountMasterGetByCodeModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    totalRows = json['total_rows'];
    accountCode = json['account_code'];
    accountName = json['account_name'];
    accountCreateFullName = json['account_create_full_name'];
    accountOwner = json['account_owner'];
    accountOwnerFullName = json['account_owner_full_name'];
    accountTitle = json['account_title'];
    accountType = json['account_type'];
    referralBy = json['referral_by'];
    phoneNo = json['phone_no'];
    emailId = json['email_id'];
    accountCategoryType = json['account_category_type'];
    companyProfileType = json['company_profile_type'];
    companyProfileSubType = json['company_profile_sub_type'];
    companyProfileRemark = json['company_profile_remark'];
    stateCode = json['StateCode'];
    stateName = json['StateName'];
    postCode = json['post_code'];
    permanentAddress = json['PermanentAddress'] != null
        ? new PermanentAddress.fromJson(json['PermanentAddress'])
        : null;
    noOfEmployees = json['no_of_employees'];
    annualRevenue = json['annual_revenue'];
    tatResponseType = json['tat_response_type'];
    tatResponseTime = json['tat_response_time'];
    salesRepresentative = json['sales_representative'];
    regionalServiceHead = json['regional_service_head'];
    salesRepresentativeName = json['sales_representative_name'];
    regionalServiceHeadName = json['regional_service_head_name'];
    profile = json['profile'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
    gstType = json['gst_type'];
    gstNo = json['gst_no'];
    panNo = json['pan_no'];
    ifscCode = json['ifsc_code'];
    shippingAddress = json['shipping_address'];
    shippingAddress2 = json['shipping_address2'];
    shippingCity = json['shipping_city'];
    shippingDistrict = json['shipping_district'];
    shippingPostCode = json['shipping_post_code'];
    shippingStateCode = json['shipping_state_code'];
    shippingStateName = json['shipping_state_name'];
    isReferral = json['is_referral'];
    frontlinerValue = json['frontliner_value'];
    branchHeadValue = json['branch_head_value'];
    zoneHeadValue = json['zone_head_value'];
    clustureHeadValue = json['clusture_head_value'];
    isAccountFixed = json['is_account_fixed'];
    oldCrmAccountNo = json['old_crm_account_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['total_rows'] = this.totalRows;
    data['account_code'] = this.accountCode;
    data['account_name'] = this.accountName;
    data['account_create_full_name'] = this.accountCreateFullName;
    data['account_owner'] = this.accountOwner;
    data['account_owner_full_name'] = this.accountOwnerFullName;
    data['account_title'] = this.accountTitle;
    data['account_type'] = this.accountType;
    data['referral_by'] = this.referralBy;
    data['phone_no'] = this.phoneNo;
    data['email_id'] = this.emailId;
    data['account_category_type'] = this.accountCategoryType;
    data['company_profile_type'] = this.companyProfileType;
    data['company_profile_sub_type'] = this.companyProfileSubType;
    data['company_profile_remark'] = this.companyProfileRemark;
    data['StateCode'] = this.stateCode;
    data['StateName'] = this.stateName;
    data['post_code'] = this.postCode;
    if (this.permanentAddress != null) {
      data['PermanentAddress'] = this.permanentAddress!.toJson();
    }
    data['no_of_employees'] = this.noOfEmployees;
    data['annual_revenue'] = this.annualRevenue;
    data['tat_response_type'] = this.tatResponseType;
    data['tat_response_time'] = this.tatResponseTime;
    data['sales_representative'] = this.salesRepresentative;
    data['regional_service_head'] = this.regionalServiceHead;
    data['sales_representative_name'] = this.salesRepresentativeName;
    data['regional_service_head_name'] = this.regionalServiceHeadName;
    data['profile'] = this.profile;
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    data['gst_type'] = this.gstType;
    data['gst_no'] = this.gstNo;
    data['pan_no'] = this.panNo;
    data['ifsc_code'] = this.ifscCode;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_address2'] = this.shippingAddress2;
    data['shipping_city'] = this.shippingCity;
    data['shipping_district'] = this.shippingDistrict;
    data['shipping_post_code'] = this.shippingPostCode;
    data['shipping_state_code'] = this.shippingStateCode;
    data['shipping_state_name'] = this.shippingStateName;
    data['is_referral'] = this.isReferral;
    data['frontliner_value'] = this.frontlinerValue;
    data['branch_head_value'] = this.branchHeadValue;
    data['zone_head_value'] = this.zoneHeadValue;
    data['clusture_head_value'] = this.clustureHeadValue;
    data['is_account_fixed'] = this.isAccountFixed;
    data['old_crm_account_no'] = this.oldCrmAccountNo;
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
