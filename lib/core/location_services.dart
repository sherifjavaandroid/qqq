import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:easycut/core/services/services.dart';

class LocationServices extends GetxController {
  var currentPosition = Rxn<Position>();
  var address = ''.obs;
  var city = ''.obs;
  var country = ''.obs;
  var isLoading = false.obs;
  var hasPermission = false.obs;

  final MyServices myServices = Get.find();

  @override
  void onInit() {
    super.onInit();
    checkLocationPermission();
  }

  // Check if location permissions are granted
  Future<void> checkLocationPermission() async {
    isLoading.value = true;
    bool serviceEnabled;
    LocationPermission permission;

    try {
      // Test if location services are enabled
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        hasPermission.value = false;
        isLoading.value = false;
        return;
      }

      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          hasPermission.value = false;
          isLoading.value = false;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        hasPermission.value = false;
        isLoading.value = false;
        return;
      }

      hasPermission.value = true;
      await getCurrentPosition();
    } catch (e) {
      print('Error checking location permission: $e');
      hasPermission.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  // Get the current position
  Future<void> getCurrentPosition() async {
    isLoading.value = true;

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPosition.value = position;
      await getAddressFromLatLng(position);

      // Save location data to shared preferences
      if (country.value.isNotEmpty && city.value.isNotEmpty) {
        myServices.sharedPreferences.setString('user_country', country.value);
        myServices.sharedPreferences.setString('user_city', city.value);
        myServices.sharedPreferences.setString('user_address', address.value);
        myServices.sharedPreferences.setDouble('user_latitude', position.latitude);
        myServices.sharedPreferences.setDouble('user_longitude', position.longitude);
      }
    } catch (e) {
      print('Error getting current position: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Get address from latitude and longitude
  Future<void> getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        address.value = '${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}';
        city.value = place.locality ?? '';
        country.value = place.country ?? '';
      }
    } catch (e) {
      print('Error getting address: $e');
    }
  }

  // Show dialog to request location permission
  void showLocationPermissionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Location Permission'.tr),
          content: Text('EasyCut needs access to your location to show nearby salons. Please grant location permission.'.tr),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Settings'.tr),
              onPressed: () {
                Navigator.of(context).pop();
                Geolocator.openAppSettings();
              },
            ),
          ],
        );
      },
    );
  }

  // Calculate distance between two points
  double calculateDistance(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }
}