class CheckInResponse {
  String? condition;
  String? message;
  String? documentNo;
  int? vehileTypeId;
  String? vehileType;
  String? grade;
  int? isMaintainKm;
  double? ratePerKm;
  String? placeToVisit;
  int? isWorkingWith;
  String? workingWithEmail;
  int? isCheckin;
  String? createdBy;
  String? createdOn;
  String? vehicleNo;
  double? openingKm;
  double? closingKm;
  double? totalKm;
  double? travellingAmount;
  String? daCode;
  String? daName;
  String? remarks;
  String? expenseDate;
  int? isCheckOut;
  String? completedOn;
  int? isApprove;
  String? aprroveStatus;
  String? approveOn;
  double? totalLineAmount;
  CheckInImages? checkInImages;
  CheckInImages? checkOutImages;
  List<Lines>? lines;

  CheckInResponse(
      {this.condition,
        this.message,
        this.documentNo,
        this.vehileTypeId,
        this.vehileType,
        this.grade,
        this.isMaintainKm,
        this.ratePerKm,
        this.placeToVisit,
        this.isWorkingWith,
        this.workingWithEmail,
        this.isCheckin,
        this.createdBy,
        this.createdOn,
        this.vehicleNo,
        this.openingKm,
        this.closingKm,
        this.totalKm,
        this.travellingAmount,
        this.daCode,
        this.daName,
        this.remarks,
        this.expenseDate,
        this.isCheckOut,
        this.completedOn,
        this.isApprove,
        this.aprroveStatus,
        this.approveOn,
        this.totalLineAmount,
        this.checkInImages,
        this.checkOutImages,
        this.lines});

  CheckInResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    documentNo = json['document_no'];
    vehileTypeId = json['vehile_type_id'];
    vehileType = json['vehile_type'];
    grade = json['grade'];
    isMaintainKm = json['is_maintain_km'];
    ratePerKm = json['rate_per_km'];
    placeToVisit = json['place_to_visit'];
    isWorkingWith = json['is_working_with'];
    workingWithEmail = json['working_with_email'];
    isCheckin = json['is_checkin'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    vehicleNo = json['vehicle_no'];
    openingKm = json['opening_km'];
    closingKm = json['closing_km'];
    totalKm = json['total_km'];
    travellingAmount = json['travelling_amount'];
    daCode = json['da_code'];
    daName = json['da_name'];
    remarks = json['remarks'];
    expenseDate = json['expense_date'];
    isCheckOut = json['is_check_out'];
    completedOn = json['completed_on'];
    isApprove = json['is_approve'];
    aprroveStatus = json['aprrove_status'];
    approveOn = json['approve_on'];
    totalLineAmount = json['total_line_amount'];
    checkInImages = json['checkInImages'] != null
        ? new CheckInImages.fromJson(json['checkInImages'])
        : null;
    checkOutImages = json['checkOutImages'] != null
        ? new CheckInImages.fromJson(json['checkOutImages'])
        : null;
    if (json['lines'] != null) {
      lines = <Lines>[];
      json['lines'].forEach((v) {
        lines!.add(new Lines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['document_no'] = this.documentNo;
    data['vehile_type_id'] = this.vehileTypeId;
    data['vehile_type'] = this.vehileType;
    data['grade'] = this.grade;
    data['is_maintain_km'] = this.isMaintainKm;
    data['rate_per_km'] = this.ratePerKm;
    data['place_to_visit'] = this.placeToVisit;
    data['is_working_with'] = this.isWorkingWith;
    data['working_with_email'] = this.workingWithEmail;
    data['is_checkin'] = this.isCheckin;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['vehicle_no'] = this.vehicleNo;
    data['opening_km'] = this.openingKm;
    data['closing_km'] = this.closingKm;
    data['total_km'] = this.totalKm;
    data['travelling_amount'] = this.travellingAmount;
    data['da_code'] = this.daCode;
    data['da_name'] = this.daName;
    data['remarks'] = this.remarks;
    data['expense_date'] = this.expenseDate;
    data['is_check_out'] = this.isCheckOut;
    data['completed_on'] = this.completedOn;
    data['is_approve'] = this.isApprove;
    data['aprrove_status'] = this.aprroveStatus;
    data['approve_on'] = this.approveOn;
    data['total_line_amount'] = this.totalLineAmount;
    if (this.checkInImages != null) {
      data['checkInImages'] = this.checkInImages!.toJson();
    }
    if (this.checkOutImages != null) {
      data['checkOutImages'] = this.checkOutImages!.toJson();
    }
    if (this.lines != null) {
      data['lines'] = this.lines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckInImages {
  String? frontImage;
  String? backImage;

  CheckInImages({this.frontImage, this.backImage});

  CheckInImages.fromJson(Map<String, dynamic> json) {
    frontImage = json['front_image'];
    backImage = json['back_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['front_image'] = this.frontImage;
    data['back_image'] = this.backImage;
    return data;
  }
}

class Lines {
  String? documentNo;
  int? expenseId;
  String? expenseName;
  double? expenseAmount;
  String? image_url;
  String? imageUrl2;
  String? imageUrl3;
  String? imageUrl4;
  String? local_image_path1;
  String? local_image_path2;
  String? local_image_path3;
  String? local_image_path4;
  int? imageCount;


  Lines(
      {this.documentNo,
        this.expenseId,
        this.expenseName,
        this.expenseAmount,
        this.image_url,
        this.imageUrl2,
        this.imageUrl3,
        this.imageUrl4,
        this.imageCount});

  Lines.fromJson(Map<String, dynamic> json) {
    documentNo = json['document_no'];
    expenseId = json['expense_id'];
    expenseName = json['expense_name'];
    expenseAmount = json['expense_amount'];
    image_url = json['image_url'];
    imageUrl2 = json['image_url2'];
    imageUrl3 = json['image_url3'];
    imageUrl4 = json['image_url4'];
    imageCount = json['image_count'];
    local_image_path1=null;
    local_image_path2=null;
    local_image_path3=null;
    local_image_path4=null;


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_no'] = this.documentNo;
    data['expense_id'] = this.expenseId;
    data['expense_name'] = this.expenseName;
    data['expense_amount'] = this.expenseAmount;
    data['image_count'] = this.imageCount;
    data['image_url'] = this.image_url;
    data['image_url2'] = this.imageUrl2;
    data['image_url3'] = this.imageUrl3;
    data['image_url4'] = this.imageUrl4;
    return data;
  }
}