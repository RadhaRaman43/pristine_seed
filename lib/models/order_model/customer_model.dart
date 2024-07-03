class CustomersModel {
  String? condition;
  int? totalCount;
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
  int? expiryNoOfDays;

  CustomersModel(
      {this.condition,
        this.totalCount,
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
        this.expiryNoOfDays});

  CustomersModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalCount = json['total_count'];
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
    expiryNoOfDays = json['expiry_no_of_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_count'] = this.totalCount;
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
    data['expiry_no_of_days'] = this.expiryNoOfDays;
    return data;
  }
}



















/*
class CustomersModel {
  String? condition;
  String? message;
  int? totalCount;
  String? customerNo;
  String? name;
  String? address;
  String? address2;
  String? postCode;
  String? stateCode;
  String? stateName;
  String? countryCode;
  String? countryName;
  String? salesPersonCode;
  String? salesPersonName;
  String? phoneNo;
  String? emailId;
  String? contactPersonName;
  String? mobileNo;
  String? customerType;
  String? customerPriceGroup;
  String? customerDiscountGroup;
  String? paymentTerm;
  String? gstRegistrationNo;
  String? panNo;
  String? aadharNo;
  String? seedLicenceNo;
  String? validity;
  double? creditLimit;
  double? sixtyDaysOutstanding;
  double? currentOutstanding;
  double? appOrderValue;
  int? isActive;
  String? createdBy;
  String? createdOn;
  String? updatedBy;
  String? updatedOn;
  String? appOrderValueUpdatedBy;
  String? appOrderValueUpdatedOn;
  int? expiryNoOfDays;
  CustomersModel(
      {
        this.condition,
        this.message,
        this.totalCount,
        this.customerNo,
        this.name,
        this.address,
        this.address2,
        this.postCode,
        this.stateCode,
        this.stateName,
        this.countryCode,
        this.countryName,
        this.salesPersonCode,
        this.salesPersonName,
        this.phoneNo,
        this.emailId,
        this.contactPersonName,
        this.mobileNo,
        this.customerType,
        this.customerPriceGroup,
        this.customerDiscountGroup,
        this.paymentTerm,
        this.gstRegistrationNo,
        this.panNo,
        this.aadharNo,
        this.seedLicenceNo,
        this.validity,
        this.creditLimit,
        this.sixtyDaysOutstanding,
        this.currentOutstanding,
        this.appOrderValue,
        this.isActive,
        this.createdBy,
        this.createdOn,
        this.updatedBy,
        this.updatedOn,
        this.appOrderValueUpdatedBy,
        this.appOrderValueUpdatedOn,
        this.expiryNoOfDays});

  CustomersModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    totalCount = json['total_count'];
    customerNo = json['customer_no'];
    name = json['name'];
    address = json['address'];
    address2 = json['address2'];
    postCode = json['post_code'];
    stateCode = json['state_code'];
    stateName = json['state_name'];
    countryCode = json['country_code'];
    countryName = json['country_name'];
    salesPersonCode = json['sales_person_code'];
    salesPersonName = json['sales_person_name'];
    phoneNo = json['phone_no'];
    emailId = json['email_id'];
    contactPersonName = json['contact_person_name'];
    mobileNo = json['mobile_no'];
    customerType = json['customer_type'];
    customerPriceGroup = json['customer_price_group'];
    customerDiscountGroup = json['customer_discount_group'];
    paymentTerm = json['payment_term'];
    gstRegistrationNo = json['gst_registration_no'];
    panNo = json['pan_no'];
    aadharNo = json['aadhar_no'];
    seedLicenceNo = json['seed_licence_no'];
    validity = json['validity'];
    creditLimit = json['credit_limit'];
    sixtyDaysOutstanding = json['sixty_days_outstanding'];
    currentOutstanding = json['current_outstanding'];
    appOrderValue = json['app_order_value'];
    isActive = json['is_active'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    updatedBy = json['updated_by'];
    updatedOn = json['updated_on'];
    appOrderValueUpdatedBy = json['app_order_value_updated_by'];
    appOrderValueUpdatedOn = json['app_order_value_updated_on'];
    expiryNoOfDays = json['expiry_no_of_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['total_count'] = this.totalCount;
    data['customer_no'] = this.customerNo;
    data['name'] = this.name;
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['post_code'] = this.postCode;
    data['state_code'] = this.stateCode;
    data['state_name'] = this.stateName;
    data['country_code'] = this.countryCode;
    data['country_name'] = this.countryName;
    data['sales_person_code'] = this.salesPersonCode;
    data['sales_person_name'] = this.salesPersonName;
    data['phone_no'] = this.phoneNo;
    data['email_id'] = this.emailId;
    data['contact_person_name'] = this.contactPersonName;
    data['mobile_no'] = this.mobileNo;
    data['customer_type'] = this.customerType;
    data['customer_price_group'] = this.customerPriceGroup;
    data['customer_discount_group'] = this.customerDiscountGroup;
    data['payment_term'] = this.paymentTerm;
    data['gst_registration_no'] = this.gstRegistrationNo;
    data['pan_no'] = this.panNo;
    data['aadhar_no'] = this.aadharNo;
    data['seed_licence_no'] = this.seedLicenceNo;
    data['validity'] = this.validity;
    data['credit_limit'] = this.creditLimit;
    data['sixty_days_outstanding'] = this.sixtyDaysOutstanding;
    data['current_outstanding'] = this.currentOutstanding;
    data['app_order_value'] = this.appOrderValue;
    data['is_active'] = this.isActive;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['updated_by'] = this.updatedBy;
    data['updated_on'] = this.updatedOn;
    data['app_order_value_updated_by'] = this.appOrderValueUpdatedBy;
    data['app_order_value_updated_on'] = this.appOrderValueUpdatedOn;
    data['expiry_no_of_days'] = this.expiryNoOfDays;
    return data;
  }
}*/
