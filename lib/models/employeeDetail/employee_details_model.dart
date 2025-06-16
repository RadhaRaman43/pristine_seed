class EmployeeDetailsGetResponse {
  String? condition;
  String? empId;
  String? loginEmailId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? dob;
  String? gender;
  String? grade;
  String? joiningDate;
  String? address1;
  String? address2;
  String? postCode;
  String? city;
  String? state;
  String? country;
  int? block;
  String? personalEMail;
  String? phoneNo;
  String? mobileNo;
  String? panNo;
  String? designation;
  String? department;
  int? isHo;
  String? clusterId;
  String? locationId;
  String? companyId;
  String? shiftCode;
  String? managerId;
  String? createdBy;
  String? createdOn;
  String? inspectionType;
  int? isGeoTag;
  String? level;
  String? geoName;
  String? geoValue;
  int? isAdminWritePermission;
  String? clusterName;
  String? regionName;
  String? salesPersonEmpCode;
  String? salesPersonName;
  int? checkIn;
  String? shiftStartTime;
  String? shiftEndTime;
  int? navSync;
  String? locationName;
  String? userFullName;
  List<UserGeoHierarchy>? userGeoHierarchy;

  EmployeeDetailsGetResponse(
      {this.condition,
        this.empId,
        this.loginEmailId,
        this.firstName,
        this.middleName,
        this.lastName,
        this.dob,
        this.gender,
        this.grade,
        this.joiningDate,
        this.address1,
        this.address2,
        this.postCode,
        this.city,
        this.state,
        this.country,
        this.block,
        this.personalEMail,
        this.phoneNo,
        this.mobileNo,
        this.panNo,
        this.designation,
        this.department,
        this.isHo,
        this.clusterId,
        this.locationId,
        this.companyId,
        this.shiftCode,
        this.managerId,
        this.createdBy,
        this.createdOn,
        this.inspectionType,
        this.isGeoTag,
        this.level,
        this.geoName,
        this.geoValue,
        this.isAdminWritePermission,
        this.clusterName,
        this.regionName,
        this.salesPersonEmpCode,
        this.salesPersonName,
        this.checkIn,
        this.shiftStartTime,
        this.shiftEndTime,
        this.navSync,
        this.locationName,
        this.userFullName,
        this.userGeoHierarchy});

  EmployeeDetailsGetResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    empId = json['emp_id'];
    loginEmailId = json['login_email_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    dob = json['dob'];
    gender = json['gender'];
    grade = json['grade'];
    joiningDate = json['joining_date'];
    address1 = json['address_1'];
    address2 = json['address_2'];
    postCode = json['post_code'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    block = json['block'];
    personalEMail = json['personal_e_mail'];
    phoneNo = json['phone_no'];
    mobileNo = json['mobile_no'];
    panNo = json['pan_no'];
    designation = json['designation'];
    department = json['department'];
    isHo = json['is_ho'];
    clusterId = json['cluster_id'];
    locationId = json['location_id'];
    companyId = json['company_id'];
    shiftCode = json['shift_code'];
    managerId = json['manager_id'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    inspectionType = json['inspection_type'];
    isGeoTag = json['is_geo_tag'];
    level = json['level'];
    geoName = json['geo_name'];
    geoValue = json['geo_value'];
    isAdminWritePermission = json['is_admin_write_permission'];
    clusterName = json['cluster_name'];
    regionName = json['region_name'];
    salesPersonEmpCode = json['sales_person_emp_code'];
    salesPersonName = json['sales_person_name'];
    checkIn = json['check_in'];
    shiftStartTime = json['shift_start_time'];
    shiftEndTime = json['shift_end_time'];
    navSync = json['nav_sync'];
    locationName = json['location_name'];
    userFullName = json['user_full_name'];
    if (json['user_geo_hierarchy'] != null) {
      userGeoHierarchy = <UserGeoHierarchy>[];
      json['user_geo_hierarchy'].forEach((v) {
        userGeoHierarchy!.add(new UserGeoHierarchy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['emp_id'] = this.empId;
    data['login_email_id'] = this.loginEmailId;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['grade'] = this.grade;
    data['joining_date'] = this.joiningDate;
    data['address_1'] = this.address1;
    data['address_2'] = this.address2;
    data['post_code'] = this.postCode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['block'] = this.block;
    data['personal_e_mail'] = this.personalEMail;
    data['phone_no'] = this.phoneNo;
    data['mobile_no'] = this.mobileNo;
    data['pan_no'] = this.panNo;
    data['designation'] = this.designation;
    data['department'] = this.department;
    data['is_ho'] = this.isHo;
    data['cluster_id'] = this.clusterId;
    data['location_id'] = this.locationId;
    data['company_id'] = this.companyId;
    data['shift_code'] = this.shiftCode;
    data['manager_id'] = this.managerId;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['inspection_type'] = this.inspectionType;
    data['is_geo_tag'] = this.isGeoTag;
    data['level'] = this.level;
    data['geo_name'] = this.geoName;
    data['geo_value'] = this.geoValue;
    data['is_admin_write_permission'] = this.isAdminWritePermission;
    data['cluster_name'] = this.clusterName;
    data['region_name'] = this.regionName;
    data['sales_person_emp_code'] = this.salesPersonEmpCode;
    data['sales_person_name'] = this.salesPersonName;
    data['check_in'] = this.checkIn;
    data['shift_start_time'] = this.shiftStartTime;
    data['shift_end_time'] = this.shiftEndTime;
    data['nav_sync'] = this.navSync;
    data['location_name'] = this.locationName;
    data['user_full_name'] = this.userFullName;
    if (this.userGeoHierarchy != null) {
      data['user_geo_hierarchy'] =
          this.userGeoHierarchy!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}


class UserGeoHierarchy {
  String? approverEmail;
  int? levelSeq;
  String? levelName;
  String? geoName;
  String? geoValue;
  int? myLevel;
  String? approvedFullName;

  UserGeoHierarchy(
      {this.approverEmail,
        this.levelSeq,
        this.levelName,
        this.geoName,
        this.geoValue,
        this.myLevel,
        this.approvedFullName});

  UserGeoHierarchy.fromJson(Map<String, dynamic> json) {
    approverEmail = json['approver_email'];
    levelSeq = json['level_seq'];
    levelName = json['level_name'];
    geoName = json['geo_name'];
    geoValue = json['geo_value'];
    myLevel = json['my_level'];
    approvedFullName = json['approved_full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['approver_email'] = this.approverEmail;
    data['level_seq'] = this.levelSeq;
    data['level_name'] = this.levelName;
    data['geo_name'] = this.geoName;
    data['geo_value'] = this.geoValue;
    data['my_level'] = this.myLevel;
    data['approved_full_name'] = this.approvedFullName;
    return data;
  }
}