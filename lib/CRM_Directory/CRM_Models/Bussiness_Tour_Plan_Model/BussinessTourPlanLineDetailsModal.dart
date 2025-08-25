class BussinessTourPlanLineDetailsModal {
  String? condition;
  String? totalRows;
  String? approvalStatus;
  String? tourID;
  String? tourDate;
  int? noOfDays;
  String? cluster;
  String? region;
  String? touringRegion;
  String? touringDistrict;
  String? tourType;
  String? customer;
  String? customerName;
  String? meetingWith;
  String? objective;
  String? remarks;
  String? accompaniedWith;
  String? createdOn;
  String? createdBy;
  String? ownerName;

  BussinessTourPlanLineDetailsModal(
      {this.condition,
        this.totalRows,
        this.approvalStatus,
        this.tourID,
        this.tourDate,
        this.noOfDays,
        this.cluster,
        this.region,
        this.touringRegion,
        this.touringDistrict,
        this.tourType,
        this.customer,
        this.customerName,
        this.meetingWith,
        this.objective,
        this.remarks,
        this.accompaniedWith,
        this.createdOn,
        this.createdBy,
        this.ownerName});

  BussinessTourPlanLineDetailsModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    totalRows = json['total_rows'];
    approvalStatus = json['Approval_Status'];
    tourID = json['Tour_ID'];
    tourDate = json['Tour_Date'];
    noOfDays = json['no_of_days'];
    cluster = json['Cluster'];
    region = json['Region'];
    touringRegion = json['Touring_Region'];
    touringDistrict = json['Touring_District'];
    tourType = json['Tour_Type'];
    customer = json['Customer'];
    customerName = json['CustomerName'];
    meetingWith = json['Meeting_with'];
    objective = json['Objective'];
    remarks = json['Remarks'];
    accompaniedWith = json['Accompanied_with'];
    createdOn = json['Created_On'];
    createdBy = json['Created_By'];
    ownerName = json['Owner_Name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['total_rows'] = this.totalRows;
    data['Approval_Status'] = this.approvalStatus;
    data['Tour_ID'] = this.tourID;
    data['Tour_Date'] = this.tourDate;
    data['no_of_days'] = this.noOfDays;
    data['Cluster'] = this.cluster;
    data['Region'] = this.region;
    data['Touring_Region'] = this.touringRegion;
    data['Touring_District'] = this.touringDistrict;
    data['Tour_Type'] = this.tourType;
    data['Customer'] = this.customer;
    data['CustomerName'] = this.customerName;
    data['Meeting_with'] = this.meetingWith;
    data['Objective'] = this.objective;
    data['Remarks'] = this.remarks;
    data['Accompanied_with'] = this.accompaniedWith;
    data['Created_On'] = this.createdOn;
    data['Created_By'] = this.createdBy;
    data['Owner_Name'] = this.ownerName;
    return data;
  }
}