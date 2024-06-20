class CoordinatesReponse {
  String? condition;
  int? id;
  String? startDate;
  double? fromLatitude;
  double? fromLongitude;
  String? fromLocality;
  String? fromArea;
  String? fromPostalCode;
  String? fromCountry;
  String? createdBy;
  String? message;
  String? createdOn;


  CoordinatesReponse(
      {this.condition,
        this.id,
        this.startDate,
        this.fromLatitude,
        this.fromLongitude,
        this.fromLocality,
        this.fromArea,
        this.fromPostalCode,
        this.fromCountry,
        this.createdBy,
        this.message,
        this.createdOn});

  CoordinatesReponse.fromJson(Map<String, dynamic> json) {
    condition = json['condition'];
    id = json['id'];
    startDate = json['start_date'];
    fromLatitude = json['from_latitude'] is String ? double.tryParse(json['from_latitude']) : json['from_latitude'];
    fromLongitude = json['from_longitude'] is String ? double.tryParse(json['from_longitude']) : json['from_longitude'];
    fromLocality = json['from_locality'];
    fromArea = json['from_area'];
    fromPostalCode = json['from_postal_code'];
    fromCountry = json['from_country'];
    createdBy = json['created_by'];
    message = json['message'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition'] = this.condition;
    data['id'] = this.id;
    data['start_date'] = this.startDate;
    data['from_latitude'] = this.fromLatitude;
    data['from_longitude'] = this.fromLongitude;
    data['from_locality'] = this.fromLocality;
    data['from_area'] = this.fromArea;
    data['from_postal_code'] = this.fromPostalCode;
    data['from_country'] = this.fromCountry;
    data['created_by'] = this.createdBy;
    data['message'] = this.message;
    data['created_on'] = this.createdOn;
    return data;
  }
}