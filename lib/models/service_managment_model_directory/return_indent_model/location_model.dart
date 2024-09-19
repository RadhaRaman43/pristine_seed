class LocationResponse {
  String? condition;
  String? locationId;
  String? locationName;
  String? companyId;
  String? locationType;
  String? address;
  String? city;
  String? state;
  String? country;
  String? gstType;
  String? gstNo;
  String? contactNo;
  String? email;
  int? isHo;
  String? stateName;
  String? postCode;
  String? govermentStateCode;
  String? createdBy;
  String? createdOn;
  String? locPrefix;

  LocationResponse(
      {this.condition,
        this.locationId,
        this.locationName,
        this.companyId,
        this.locationType,
        this.address,
        this.city,
        this.state,
        this.country,
        this.gstType,
        this.gstNo,
        this.contactNo,
        this.email,
        this.isHo,
        this.stateName,
        this.postCode,
        this.govermentStateCode,
        this.createdBy,
        this.createdOn,
        this.locPrefix});

  LocationResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    locationId = json['location_id'];
    locationName = json['location_name'];
    companyId = json['company_id'];
    locationType = json['location_type'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    gstType = json['gst_type'];
    gstNo = json['gst_no'];
    contactNo = json['contact_no'];
    email = json['email'];
    isHo = json['is_ho'];
    stateName = json['state_name'];
    postCode = json['post_code'];
    govermentStateCode = json['goverment_state_code'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    locPrefix = json['loc_prefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['location_id'] = this.locationId;
    data['location_name'] = this.locationName;
    data['company_id'] = this.companyId;
    data['location_type'] = this.locationType;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['gst_type'] = this.gstType;
    data['gst_no'] = this.gstNo;
    data['contact_no'] = this.contactNo;
    data['email'] = this.email;
    data['is_ho'] = this.isHo;
    data['state_name'] = this.stateName;
    data['post_code'] = this.postCode;
    data['goverment_state_code'] = this.govermentStateCode;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['loc_prefix'] = this.locPrefix;
    return data;
  }
}