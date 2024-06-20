class VehicleNoResponse {
  String? condition;
  int? vehicleTypeId;
  String vehicleNumber="";
  double? openingKm;
  double? closingKm;

  VehicleNoResponse(
      {this.condition,
        this.vehicleTypeId,
        required this.vehicleNumber,
        this.openingKm,
        this.closingKm});

  VehicleNoResponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    vehicleTypeId = json['vehicle_type_id'];
    vehicleNumber = json['vehicle_number'] ??'';
    openingKm = json['opening_km'];
    closingKm = json['closing_km'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['vehicle_type_id'] = this.vehicleTypeId;
    data['vehicle_number'] = this.vehicleNumber;
    data['opening_km'] = this.openingKm;
    data['closing_km'] = this.closingKm;
    return data;
  }
}