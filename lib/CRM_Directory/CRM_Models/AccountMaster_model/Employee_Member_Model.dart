class EmployeeMemberModel {
  String? condition;
  String? empId;
  String? loginEmailId;
  String? firstName;
  String? middleName;
  String? lastName;
  String? fullName;
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
  int? isHeadofficePermission;
  String? clusterName;
  String? regionName;
  String? salesPersonEmpCode;
  String? salesPersonName;
  String? calendarCode;
  String? attendanceStartDate;
  int? isTargetConsidered;
  int? isDownloadPermission;
  String? userType;
  String? userTypeName;
  String? locationName;
  String? userFullName;

  EmployeeMemberModel(
      {this.condition,
        this.empId,
        this.loginEmailId,
        this.firstName,
        this.middleName,
        this.lastName,
        this.fullName,
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
        this.isHeadofficePermission,
        this.clusterName,
        this.regionName,
        this.salesPersonEmpCode,
        this.salesPersonName,
        this.calendarCode,
        this.attendanceStartDate,
        this.isTargetConsidered,
        this.isDownloadPermission,
        this.userType,
        this.userTypeName,
        this.locationName,
        this.userFullName});

  EmployeeMemberModel.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    empId = json['emp_id'];
    loginEmailId = json['login_email_id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
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
    isHeadofficePermission = json['is_headoffice_permission'];
    clusterName = json['cluster_name'];
    regionName = json['region_name'];
    salesPersonEmpCode = json['sales_person_emp_code'];
    salesPersonName = json['sales_person_name'];
    calendarCode = json['calendar_code'];
    attendanceStartDate = json['attendance_start_date'];
    isTargetConsidered = json['is_target_considered'];
    isDownloadPermission = json['is_download_permission'];
    userType = json['user_type'];
    userTypeName = json['user_type_name'];
    locationName = json['location_name'];
    userFullName = json['user_full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['emp_id'] = this.empId;
    data['login_email_id'] = this.loginEmailId;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['full_name'] = this.fullName;
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
    data['is_headoffice_permission'] = this.isHeadofficePermission;
    data['cluster_name'] = this.clusterName;
    data['region_name'] = this.regionName;
    data['sales_person_emp_code'] = this.salesPersonEmpCode;
    data['sales_person_name'] = this.salesPersonName;
    data['calendar_code'] = this.calendarCode;
    data['attendance_start_date'] = this.attendanceStartDate;
    data['is_target_considered'] = this.isTargetConsidered;
    data['is_download_permission'] = this.isDownloadPermission;
    data['user_type'] = this.userType;
    data['user_type_name'] = this.userTypeName;
    data['location_name'] = this.locationName;
    data['user_full_name'] = this.userFullName;
    return data;
  }
}