import 'package:easycut/controller/home/home_controller.dart';
import 'package:easycut/data/model/searchsalon.dart';
import 'package:easycut/core/class/status_request.dart'; // Add this import
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Extension to add enhanced salon search functionality to HomeController
extension SalonSearchAPI on HomeControllerImp {
  // Method to search for salons using the API
  Future<List<SearchsalonModel>> searchSalonsApi(String query) async {
    try {
      if (query.isEmpty) {
        return [];
      }

      final response = await http.get(
        Uri.parse('${_getSearchSalonUrl()}?search=$query'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (kDebugMode) {
          print("Search response: $responseData");
        }

        if (responseData is List) {
          return responseData
              .map((item) => SearchsalonModel.fromJson(item as Map<String, dynamic>))
              .toList();
        } else if (responseData is Map && responseData.containsKey('data')) {
          final List<dynamic> data = responseData['data'];
          return data
              .map((item) => SearchsalonModel.fromJson(item as Map<String, dynamic>))
              .toList();
        }
      }

      return [];
    } catch (e) {
      if (kDebugMode) {
        print("Error searching salons: $e");
      }
      return [];
    }
  }

  // Updated searchSalon method to use the API endpoint
  Future<void> searchSalonWithApi(String search) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      // Get results from the API
      searchResults = await searchSalonsApi(search);

      // Filter search results if a classification is selected
      if (currentClassification.value != "all") {
        searchResults = searchResults
            .where((salon) => salon.classification == currentClassification.value)
            .toList();
      }

      statusRequest = searchResults.isNotEmpty
          ? StatusRequest.success
          : StatusRequest.failure;
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

  // Helper method to get URL (to avoid instance field in extension)
  String _getSearchSalonUrl() => "https://dashboard.easycuteg.com/api/salon/search";
}