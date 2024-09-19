class ConsigneeModel {
  String? condition;
  String? message;
  String? currentConsigneeId;
  String? consigneeId;
  String? partyNo;
  String? name;
  String? contactName;
  String? mobileNo;
  String? address;
  String? address2;
  String? city;
  String? pincode;
  String? createdBy;
  String? createdOn;
  String? updatedOn;
  String? stateCode;
  String? stateName;
  int? isBusCen;

  ConsigneeModel(
      {this.condition,
        this.message,
        this.currentConsigneeId,
        this.consigneeId,
        this.partyNo,
        this.name,
        this.contactName,
        this.mobileNo,
        this.address,
        this.address2,
        this.city,
        this.pincode,
        this.createdBy,
        this.createdOn,
        this.updatedOn,
        this.stateCode,
        this.stateName,
        this.isBusCen});

  ConsigneeModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    currentConsigneeId = json['current_consignee_id'];
    consigneeId = json['consignee_id'];
    partyNo = json['party_no'];
    name = json['name'];
    contactName = json['contact_name'];
    mobileNo = json['mobile_no'];
    address = json['address'];
    address2 = json['address2'];
    city = json['city'];
    pincode = json['pincode'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    updatedOn = json['updated_on'];
    stateCode = json['state_code'];
    stateName = json['state_name'];
    isBusCen = json['is_bus_cen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['current_consignee_id'] = this.currentConsigneeId;
    data['consignee_id'] = this.consigneeId;
    data['party_no'] = this.partyNo;
    data['name'] = this.name;
    data['contact_name'] = this.contactName;
    data['mobile_no'] = this.mobileNo;
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['updated_on'] = this.updatedOn;
    data['state_code'] = this.stateCode;
    data['state_name'] = this.stateName;
    data['is_bus_cen'] = this.isBusCen;
    return data;
  }
}