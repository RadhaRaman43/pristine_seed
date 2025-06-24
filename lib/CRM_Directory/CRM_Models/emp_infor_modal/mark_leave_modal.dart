class AttendanceLeaveModal {
  String? condition;
  String? message;
  int? id;
  String? empName;
  String? locationCode;
  String? workingDate;
  String? timeIn;
  String? timeOut;
  String? status;
  String? remoteType;
  String? leaveCode;
  String? leaveReason;
  String? salaryPosted;
  int? isPaid;
  int? isHalfDayPaid;
  int? totalMinutes;
  int? lateMinutes;
  int? earlyLeaveMinutes;
  String? otMinutes;
  String? remarks;
  String? fromLatitude;
  String? fromLongitude;
  String? fromLocality;
  String? fromArea;
  String? fromPostalCode;
  String? fromCountry;
  String? toLatitude;
  String? toLongitude;
  String? toLocality;
  String? toArea;
  String? toPostalCode;
  String? toCountry;
  int? signIn;
  int? signOut;
  int? isLeave;
  int? isHalfDay;
  int? isShortLeave;
  String? shortLeaveTime;
  int? isDone;
  int? isTwinBabies;
  int? isCompOff;
  String? babyName;
  String? babyGender;
  String? babyBirthDate;
  String? compOffDate;
  String? approveStatus;
  String? approvedBy;
  String? approvedOn;
  String? rejectRemarks;
  String? createdBy;
  String? createdOn;
  String? leaveDescription;

  AttendanceLeaveModal(
      {this.condition,
        this.message,
        this.id,
        this.empName,
        this.locationCode,
        this.workingDate,
        this.timeIn,
        this.timeOut,
        this.status,
        this.remoteType,
        this.leaveCode,
        this.leaveReason,
        this.salaryPosted,
        this.isPaid,
        this.isHalfDayPaid,
        this.totalMinutes,
        this.lateMinutes,
        this.earlyLeaveMinutes,
        this.otMinutes,
        this.remarks,
        this.fromLatitude,
        this.fromLongitude,
        this.fromLocality,
        this.fromArea,
        this.fromPostalCode,
        this.fromCountry,
        this.toLatitude,
        this.toLongitude,
        this.toLocality,
        this.toArea,
        this.toPostalCode,
        this.toCountry,
        this.signIn,
        this.signOut,
        this.isLeave,
        this.isHalfDay,
        this.isShortLeave,
        this.shortLeaveTime,
        this.isDone,
        this.isTwinBabies,
        this.isCompOff,
        this.babyName,
        this.babyGender,
        this.babyBirthDate,
        this.compOffDate,
        this.approveStatus,
        this.approvedBy,
        this.approvedOn,
        this.rejectRemarks,
        this.createdBy,
        this.createdOn,
        this.leaveDescription});

  AttendanceLeaveModal.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    id = json['id'];
    empName = json['emp_name'];
    locationCode = json['location_code'];
    workingDate = json['working_date'];
    timeIn = json['time_in'];
    timeOut = json['time_out'];
    status = json['status'];
    remoteType = json['remote_type'];
    leaveCode = json['leave_code'];
    leaveReason = json['leave_reason'];
    salaryPosted = json['salary_posted'];
    isPaid = json['is_paid'];
    isHalfDayPaid = json['is_half_day_paid'];
    totalMinutes = json['total_minutes'];
    lateMinutes = json['late_minutes'];
    earlyLeaveMinutes = json['early_leave_minutes'];
    otMinutes = json['ot_minutes'];
    remarks = json['remarks'];
    fromLatitude = json['from_latitude'];
    fromLongitude = json['from_longitude'];
    fromLocality = json['from_locality'];
    fromArea = json['from_area'];
    fromPostalCode = json['from_postal_code'];
    fromCountry = json['from_country'];
    toLatitude = json['to_latitude'];
    toLongitude = json['to_longitude'];
    toLocality = json['to_locality'];
    toArea = json['to_area'];
    toPostalCode = json['to_postal_code'];
    toCountry = json['to_country'];
    signIn = json['sign_in'];
    signOut = json['sign_out'];
    isLeave = json['is_leave'];
    isHalfDay = json['is_half_day'];
    isShortLeave = json['is_short_leave'];
    shortLeaveTime = json['short_leave_time'];
    isDone = json['is_done'];
    isTwinBabies = json['is_twin_babies'];
    isCompOff = json['is_comp_off'];
    babyName = json['baby_name'];
    babyGender = json['baby_gender'];
    babyBirthDate = json['baby_birth_date'];
    compOffDate = json['comp_off_date'];
    approveStatus = json['approve_status'];
    approvedBy = json['approved_by'];
    approvedOn = json['approved_on'];
    rejectRemarks = json['reject_remarks'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    leaveDescription = json['leave_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['id'] = this.id;
    data['emp_name'] = this.empName;
    data['location_code'] = this.locationCode;
    data['working_date'] = this.workingDate;
    data['time_in'] = this.timeIn;
    data['time_out'] = this.timeOut;
    data['status'] = this.status;
    data['remote_type'] = this.remoteType;
    data['leave_code'] = this.leaveCode;
    data['leave_reason'] = this.leaveReason;
    data['salary_posted'] = this.salaryPosted;
    data['is_paid'] = this.isPaid;
    data['is_half_day_paid'] = this.isHalfDayPaid;
    data['total_minutes'] = this.totalMinutes;
    data['late_minutes'] = this.lateMinutes;
    data['early_leave_minutes'] = this.earlyLeaveMinutes;
    data['ot_minutes'] = this.otMinutes;
    data['remarks'] = this.remarks;
    data['from_latitude'] = this.fromLatitude;
    data['from_longitude'] = this.fromLongitude;
    data['from_locality'] = this.fromLocality;
    data['from_area'] = this.fromArea;
    data['from_postal_code'] = this.fromPostalCode;
    data['from_country'] = this.fromCountry;
    data['to_latitude'] = this.toLatitude;
    data['to_longitude'] = this.toLongitude;
    data['to_locality'] = this.toLocality;
    data['to_area'] = this.toArea;
    data['to_postal_code'] = this.toPostalCode;
    data['to_country'] = this.toCountry;
    data['sign_in'] = this.signIn;
    data['sign_out'] = this.signOut;
    data['is_leave'] = this.isLeave;
    data['is_half_day'] = this.isHalfDay;
    data['is_short_leave'] = this.isShortLeave;
    data['short_leave_time'] = this.shortLeaveTime;
    data['is_done'] = this.isDone;
    data['is_twin_babies'] = this.isTwinBabies;
    data['is_comp_off'] = this.isCompOff;
    data['baby_name'] = this.babyName;
    data['baby_gender'] = this.babyGender;
    data['baby_birth_date'] = this.babyBirthDate;
    data['comp_off_date'] = this.compOffDate;
    data['approve_status'] = this.approveStatus;
    data['approved_by'] = this.approvedBy;
    data['approved_on'] = this.approvedOn;
    data['reject_remarks'] = this.rejectRemarks;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['leave_description'] = this.leaveDescription;
    return data;
  }
}