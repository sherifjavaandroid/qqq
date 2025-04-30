import 'package:easycut/core/class/status_request.dart';
import 'package:easycut/core/functions/handling_data_controller.dart';
import 'package:easycut/core/services/services.dart';
import 'package:easycut/data/data_source/remote/home/home_data.dart';
import 'package:easycut/data/model/salon_model.dart';
import 'package:easycut/data/model/salonrates.dart';
import 'package:easycut/data/model/searchsalon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/location_services.dart';

abstract class HomeController extends GetxController {
  void initialData();
  Future<void> getData();
  bool get isLoggedIn;
  void filterByClassification(String classification);
  Future<void> refreshSalonsWithLocation();
}

class HomeControllerImp extends HomeController {
  final MyServices myServices = Get.find();
  var currentRating = 0.0.obs;
  var totalRate = 0.obs;
  var isLoading = true.obs;
  int? id;
  List<SearchsalonModel> searchResults = [];

  // Classification filter
  RxString currentClassification = "all".obs;
  List<SalonModel> _allPopSalons = [];
  List<SalonModel> _allNearSalons = [];
  List<SalonModel> _allNewSalons = [];

  // Location services
  late LocationServices locationServices;
  var isLocationEnabled = false.obs;
  var userLatitude = 0.0.obs;
  var userLongitude = 0.0.obs;

  String? name;
  String? gender;
  String? country;
  String? city;
  String? address;
  String? image;

  final HomeData homeData = HomeData(Get.find());
  StatusRequest statusRequest = StatusRequest.success;
  List<SalonModel> popSalons = []; // Featured/Popular salons
  List<SalonModel> nearSalons = []; // Nearby salons
  List<SalonModel> newSalons = []; // New salons

  @override
  void initialData() {
    id = myServices.sharedPreferences.getInt('id');
    name = myServices.sharedPreferences.getString('name');
    gender = myServices.sharedPreferences.getString('gender');
    country = myServices.sharedPreferences.getString('country');
    city = myServices.sharedPreferences.getString('city');
    image = myServices.sharedPreferences.getString('image');
    address = myServices.sharedPreferences.getString('address');

    // Get location data from shared preferences if available
    userLatitude.value = myServices.sharedPreferences.getDouble('user_latitude') ?? 0.0;
    userLongitude.value = myServices.sharedPreferences.getDouble('user_longitude') ?? 0.0;

    if (userLatitude.value != 0.0 && userLongitude.value != 0.0) {
      isLocationEnabled.value = true;
    }
  }

  @override
  Future<void> getData() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await homeData.viewSalons(
          latitude: userLatitude.value,
          longitude: userLongitude.value,
          useLocation: isLocationEnabled.value
      );

      if (kDebugMode) {
        print('Response: $response');
      }
      if (kDebugMode) {
        print('userid: $id');
      }
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          // Parse nearby salons
          _allNearSalons = (response['nearsalons'] ?? []).map<SalonModel>((element) {
            return SalonModel.fromJson(element as Map<String, dynamic>);
          }).toList();

          // Parse featured/popular salons
          _allPopSalons = (response['popsalons'] ?? []).map<SalonModel>((element) {
            return SalonModel.fromJson(element as Map<String, dynamic>);
          }).toList();

          // Parse new salons
          _allNewSalons = (response['newsalons'] ?? []).map<SalonModel>((element) {
            return SalonModel.fromJson(element as Map<String, dynamic>);
          }).toList();

          // Initialize displayed lists with all salons
          nearSalons = List.from(_allNearSalons);

          // Sort popular salons by rating to ensure highest rated appear first
          _allPopSalons.sort((a, b) => (b.rate ?? 0).compareTo(a.rate ?? 0));
          popSalons = List.from(_allPopSalons);

          newSalons = List.from(_allNewSalons);

          // Make sure to save the top salons to local storage for offline display
          _saveTopSalonsToLocalStorage();
        } else {
          Get.snackbar(
            'Warning'.tr,
            'There is no data for your location'.tr,
            snackPosition: SnackPosition.TOP,
            colorText: Colors.red,
          );
          statusRequest = StatusRequest.failure;
        }
      }
    } catch (e) {
      Get.snackbar(
        'Error'.tr,
        'An error occurred while fetching data.'.tr,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
      statusRequest = StatusRequest.failure;
      if (kDebugMode) {
        print("Error fetching salons: $e");
      }

      // Try to load cached salons data
      _loadCachedSalonsData();
    } finally {
      update();
    }
  }

  // Save top salons to local storage for offline access
  void _saveTopSalonsToLocalStorage() {
    // Implementation would depend on the caching strategy
    // This is a placeholder for the actual implementation
    if (kDebugMode) {
      print("Saving ${popSalons.length} featured salons to local storage");
    }
  }

  // Load cached salons data when network request fails
  void _loadCachedSalonsData() {
    // Implementation would depend on the caching strategy
    // This is a placeholder for the actual implementation
    if (kDebugMode) {
      print("Attempting to load cached salons data");
    }
  }

  @override
  Future<void> refreshSalonsWithLocation() async {
    // Update location data
    if (locationServices.currentPosition.value != null) {
      userLatitude.value = locationServices.currentPosition.value!.latitude;
      userLongitude.value = locationServices.currentPosition.value!.longitude;

      country = locationServices.country.value;
      city = locationServices.city.value;
      address = locationServices.address.value;

      isLocationEnabled.value = true;

      // Reload data with new location
      await getData();
    }
  }

  @override
  void filterByClassification(String classification) {
    currentClassification.value = classification;

    if (classification == "all") {
      // Reset to show all salons
      nearSalons = List.from(_allNearSalons);
      popSalons = List.from(_allPopSalons);
      newSalons = List.from(_allNewSalons);
    } else {
      // Filter salons by classification
      nearSalons = _allNearSalons.where((salon) => salon.classification == classification).toList();
      popSalons = _allPopSalons.where((salon) => salon.classification == classification).toList();
      newSalons = _allNewSalons.where((salon) => salon.classification == classification).toList();
    }
    update();
  }

  Future<void> fetchRating(int salonId) async {
    isLoading.value = true;
    try {
      final response = await homeData.getsalonRating(salonId);
      if (response['status'] == 'success') {
        SalonratesModel salonRates = SalonratesModel.fromJson(response);
        if (kDebugMode) {
          print("Salon Rating: ${salonRates.data?.averageRating}");
        }
      } else {
        if (kDebugMode) {
          print("Failed to fetch rating: ${response['message']}");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching rating: $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> searchSalon(String search) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await homeData.searchSalon(
          search,
          id ?? 0,
          latitude: userLatitude.value,
          longitude: userLongitude.value,
          useLocation: isLocationEnabled.value
      );

      if (kDebugMode) {
        print('Response: $response');
        print('userid: $id');
      }

      if (response is List) {
        // API returns a direct list, so we parse it accordingly
        searchResults = response
            .map((e) => SearchsalonModel.fromJson(e as Map<String, dynamic>))
            .toList();

        // Filter search results if a classification is selected
        if (currentClassification.value != "all") {
          searchResults = searchResults.where((salon) =>
          salon.classification == currentClassification.value).toList();
        }

        statusRequest = searchResults.isNotEmpty
            ? StatusRequest.success
            : StatusRequest.failure;
      } else {
        // API returned an unexpected format
        searchResults.clear();
        statusRequest = StatusRequest.failure;
        Get.snackbar(
          'Warning'.tr,
          'Unexpected response format.'.tr,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
        );
      }
    } catch (e) {
      searchResults.clear();
      statusRequest = StatusRequest.serverFailure;
      Get.snackbar(
        'Error'.tr,
        'An error occurred while fetching data.'.tr,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
      if (kDebugMode) {
        print("Error fetching salons: $e");
      }
    } finally {
      update();
    }
  }

  @override
  void onInit() {
    locationServices = Get.put(LocationServices());
    initialData();
    getData();
    super.onInit();
  }

  @override
  bool get isLoggedIn => id == null;
}