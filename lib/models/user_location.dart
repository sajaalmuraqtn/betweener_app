import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UserLocation {
  double latitude = 0;
  double longitude = 0;

  UserLocation();

  Future<void> getUserLocation(BuildContext context) async {
    try {
      Position p = await _determinePosition(); // استقبلناه هون لحتى نستعملو
      latitude = p.latitude;
      longitude = p.longitude;
     } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("failed to get location $e")));
    }
  }

  Future<Position> _determinePosition() async { // الفنكشن اللي جبناه من الموقع
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition( desiredAccuracy: LocationAccuracy.high);
}
}