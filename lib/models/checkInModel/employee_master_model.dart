class EmpMasterResponse {
  String? condition;
  String? message;
  String? totalRows;
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
  int? checkIn;
  String? shiftStartTime;
  String? shiftEndTime;
  int? navsync;
  String? companylogourl;

  EmpMasterResponse(
      {
        this.condition,
        this.message,
        this.totalRows,
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
        this.checkIn,
        this.shiftStartTime,
        this.shiftEndTime,
        this.navsync,
        this.companylogourl});

  EmpMasterResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    totalRows = json['total_rows'];
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
    checkIn = json['check_in'];
    shiftStartTime = json['shift_start_time'];
    shiftEndTime = json['shift_end_time'];
    navsync = json['nav_sync'];
    companylogourl = json['company_logo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['total_rows'] = this.totalRows;
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
    data['check_in'] = this.checkIn;
    data['shift_start_time'] = this.shiftStartTime;
    data['shift_end_time'] = this.shiftEndTime;
    data['nav_sync'] = navsync;
    data['company_logo_url'] = companylogourl;
    return data;
  }
}