class LocationData {
  final double latitude;
  final double longitude;
  final String? area;
  final String? locality;
  final String? postal_code;
  final String? country;
  final String? battery_level;
  final String? device_id;

  LocationData({
    required this.latitude,
    required this.longitude,
    this.area,
    this.locality,
    this.postal_code,
    this.country,
    this.battery_level,
    this.device_id
  });

  factory LocationData.fromJson(Map<String, dynamic> json) {
    return LocationData(
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      area: json['area'] as String,
      locality: json['locality'] as String,
      postal_code: json['postal_code'] as String,
      country: json['country'] as String,
      battery_level: json['battery_level'] as String,
      device_id: json['device_id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'area': area,
      'locality': locality,
      'postal_code': locality,
      'country': country,
      'battery_level': battery_level,
      'device_id': device_id,
    };
  }

  @override
  String toString() {
    return 'LocationData('
        'latitude: $latitude, '
        'longitude: $longitude, '
        'area: $area, '
        'locality: $locality, '
        'postal_code: $postal_code, '
        'country: $country, '
        'battery_level: $battery_level, '
        'device_id: $device_id,)';
  }
}
