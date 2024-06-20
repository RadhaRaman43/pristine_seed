class VehicleTypeResponse {
  String? condition;
  String? message;
  int? id;
  String? vehicleType;
  String? assignPersonEmail;
  String? grade;
  String? ownerType;
  String? rateType;
  double? ratePerKm;
  int? isMaintainKm;
  String? createdBy;
  String? createdOn;
  int? isUniversal;

  VehicleTypeResponse(
      {this.condition,
        this.message,
        this.id,
        this.vehicleType,
        this.assignPersonEmail,
        this.grade,
        this.ownerType,
        this.rateType,
        this.ratePerKm,
        this.isMaintainKm,
        this.createdBy,
        this.createdOn,
        this.isUniversal});

  VehicleTypeResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    message = json['message'];
    id = json['id'];
    vehicleType = json['vehicle_type'];
    assignPersonEmail = json['assign_person_email'];
    grade = json['grade'];
    ownerType = json['owner_type'];
    rateType = json['rate_type'];
    ratePerKm = json['rate_per_km'];
    isMaintainKm = json['is_maintain_km'];
    createdBy = json['created_by'];
    createdOn = json['created_on'];
    isUniversal = json['is_universal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['message'] = this.message;
    data['id'] = this.id;
    data['vehicle_type'] = this.vehicleType;
    data['assign_person_email'] = this.assignPersonEmail;
    data['grade'] = this.grade;
    data['owner_type'] = this.ownerType;
    data['rate_type'] = this.rateType;
    data['rate_per_km'] = this.ratePerKm;
    data['is_maintain_km'] = this.isMaintainKm;
    data['created_by'] = this.createdBy;
    data['created_on'] = this.createdOn;
    data['is_universal'] = this.isUniversal;
    return data;
  }
}