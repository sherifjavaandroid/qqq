import 'package:easycut/controller/main/salon_detail_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Extension to add salon rating functionality to SalonDetailController
extension SalonRatingAPI on SalonDetailControllerImp {
  // Methods to fetch and submit salon ratings

  // Method to fetch the salon's rating
  Future<double> fetchSalonRating(int salonId, [int? userId]) async {
    try {
      final url = userId != null
          ? '${_getSalonRatingUrl()}/$salonId?user_id=$userId'
          : '${_getSalonRatingUrl()}/$salonId';

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (kDebugMode) {
          print("Salon rating response: $responseData");
        }

        if (responseData['status'] == 'success') {
          // Extract the rating data
          if (responseData['data'] != null && responseData['data']['average_rating'] != null) {
            final averageRating = double.tryParse(responseData['data']['average_rating'].toString()) ?? 0.0;
            currentRating.value = averageRating;
            return averageRating;
          }
        }
      }
      return 0.0;
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching salon rating: $e");
      }
      return 0.0;
    }
  }

  // Method to submit a rating for a salon
  Future<bool> submitSalonRating(int salonId, int rating, int userId) async {
    try {
      final response = await http.post(
        Uri.parse(_getFeedbackSalonRatingUrl()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'salon_id': salonId,
          'user_id': userId,
          'rating': rating
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (kDebugMode) {
          print("Submit rating response: $responseData");
        }

        if (responseData['status'] == 'success') {
          // Update the current rating
          currentRating.value = rating.toDouble();
          update();

          // Show success message
          Get.snackbar(
            'Success'.tr,
            'Thank you for rating this salon!'.tr,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green.withAlpha(178), // Use withAlpha instead of withOpacity
            colorText: Colors.white,
          );

          return true;
        }
      }

      // Show error message
      Get.snackbar(
        'Error'.tr,
        'Failed to submit your rating. Please try again.'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withAlpha(178), // Use withAlpha instead of withOpacity
        colorText: Colors.white,
      );

      return false;
    } catch (e) {
      if (kDebugMode) {
        print("Error submitting salon rating: $e");
      }

      // Show error message
      Get.snackbar(
        'Error'.tr,
        'An error occurred while submitting your rating'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withAlpha(178), // Use withAlpha instead of withOpacity
        colorText: Colors.white,
      );

      return false;
    }
  }

  // Method that combines the current controller's feedbackSalonRating method with the new API
  Future<void> feedbackSalonRating(int salonId, String ratingAsString, int? userId) async {
    if (userId == null) {
      Get.snackbar(
          'Warning'.tr,
          'User not logged in'.tr,
          snackPosition: SnackPosition.BOTTOM
      );
      return;
    }

    int rating = int.tryParse(ratingAsString) ?? 0;
    if (rating < 1 || rating > 5) {
      Get.snackbar(
          'Warning'.tr,
          'Invalid rating value'.tr,
          snackPosition: SnackPosition.BOTTOM
      );
      return;
    }

    // Set the current rating immediately for UI feedback
    currentRating.value = rating.toDouble();

    // Submit the rating to the API
    await submitSalonRating(salonId, rating, userId);
  }

  // Helper methods to get URLs (to avoid instance fields in extension)
  String _getFeedbackSalonRatingUrl() => "https://dashboard.easycuteg.com/api/v1/auth/salon/feedback";
  String _getSalonRatingUrl() => "https://dashboard.easycuteg.com/api/v1/auth/salon/ratings";
}