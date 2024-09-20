class AccountDraftModel {
  int? id;
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
  String? address;
  String? address2;
  String? postCode;
  String? stateCode;
  String? stateName;
  String? countryCode;
  String? countryName;
  String? city;
  String? district;
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
  String? ifscCode;
  String? shippingAddress;
  String? shippingAddress2;
  String? shippingCity;
  String? shippingDistrict;
  String? shippingPostCode;
  String? shippingStateCode;

  AccountDraftModel(
      {this.id,
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
        this.address,
        this.address2,
        this.postCode,
        this.stateCode,
        this.stateName,
        this.countryCode,
        this.countryName,
        this.city,
        this.district,
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
        this.panNo,
        this.ifscCode,
        this.shippingAddress,
        this.shippingAddress2,
        this.shippingCity,
        this.shippingDistrict,
        this.shippingPostCode,
        this.shippingStateCode});

  AccountDraftModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
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
    address = json['address'];
    address2 = json['address2'];
    postCode = json['post_code'];
    stateCode = json['state_code'];
    stateName = json['state_name'];
    countryCode = json['country_code'];
    countryName = json['country_name'];
    city = json['city'];
    district = json['district'];
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
    ifscCode = json['ifsc_code'];
    shippingAddress = json['shipping_address'];
    shippingAddress2 = json['shipping_address2'];
    shippingCity = json['shipping_city'];
    shippingDistrict = json['shipping_district'];
    shippingPostCode = json['shipping_post_code'];
    shippingStateCode = json['shipping_state_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
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
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['post_code'] = this.postCode;
    data['state_code'] = this.stateCode;
    data['state_name'] = this.stateName;
    data['country_code'] = this.countryCode;
    data['country_name'] = this.countryName;
    data['city'] = this.city;
    data['district'] = this.district;
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
    data['ifsc_code'] = this.ifscCode;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_address2'] = this.shippingAddress2;
    data['shipping_city'] = this.shippingCity;
    data['shipping_district'] = this.shippingDistrict;
    data['shipping_post_code'] = this.shippingPostCode;
    data['shipping_state_code'] = this.shippingStateCode;
    return data;
  }
}
