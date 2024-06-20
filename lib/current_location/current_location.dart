import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../utils/app_utils.dart';
class LocationData {
  double latitude = 0.0;
  double longitude = 0.0;
  String locality = "";
  String postalCode = "";
  String country = "";
  String area = "";

  Future<void> getCurrentLocation() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      latitude = position.latitude;
      longitude = position.longitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        locality = placemark.locality ?? "";
        area = placemark.administrativeArea ?? "";
        postalCode = placemark.postalCode ?? "";
        country = placemark.country ?? "";

        currentAddress =
        '${placemark.street}, ${placemark.subLocality}, ${placemark.subAdministrativeArea}, ${placemark.postalCode}';
        print(currentAddress);
      }
    } catch (e) {
      // Handle location error
      print("Error getting current location: $e");
    }
  }

  String? currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
     // Utils.sanckBarError("Location", 'Location permission are  denied.''Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        //Utils.sanckBarError("Location", 'Location permission are  denied.');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Utils.sanckBarError("Location", 'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      _currentPosition = position;
      getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      print(e);
    });
  }

  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
        _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress =
      '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea},'
          ' ${place.postalCode},${place.administrativeArea},${place.locality},${placemarks},${place.name},${place.locality}';
      print(currentAddress);
    }).catchError((e) {
      print(e);
    });
  }
}