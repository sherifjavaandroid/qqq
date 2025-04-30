import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../core/shared/widgets/big_text.dart';
import '../../core/shared/widgets/small_text.dart';
import '../../data/data_source/remote/home/book_op.dart';

class BookingRatingController extends GetxController {
  final int bookingId;

  // Services
  final MyServices myServices = Get.find();
  late BookingOperationsData bookingOperations;

  // State variables
  int serviceQualityRating = 0;
  int cleanlinessRating = 0;
  int customerServiceRating = 0;
  final TextEditingController commentController = TextEditingController();

  // API endpoints
  final String submitRatingUrl = "https://dashboard.easycuteg.com/api/v1/auth/rating/submit";
  final String checkRatingUrl = "https://dashboard.easycuteg.com/api/v1/auth/rating/check";

  // Validation check
  bool get canSubmit =>
      serviceQualityRating > 0 &&
          cleanlinessRating > 0 &&
          customerServiceRating > 0;

  BookingRatingController({
    required this.bookingId,
  }) {
    bookingOperations = BookingOperationsData(Get.find());
  }

  void updateServiceQualityRating(int rating) {
    serviceQualityRating = rating;
    update();
  }

  void updateCleanlinessRating(int rating) {
    cleanlinessRating = rating;
    update();
  }

  void updateCustomerServiceRating(int rating) {
    customerServiceRating = rating;
    update();
  }

  Future<void> submitRating() async {
    if (!canSubmit) {
      Get.snackbar(
          'Error'.tr,
          'Please rate all criteria'.tr,
          snackPosition: SnackPosition.BOTTOM
      );
      return;
    }

    try {
      // Get user ID from shared preferences
      final userId = myServices.sharedPreferences.getInt('id');

      // Prepare request data
      final requestData = {
        'bookingId': bookingId,
        'serviceQuality': serviceQualityRating,
        'cleanliness': cleanlinessRating,
        'customerService': customerServiceRating,
        'comment': commentController.text,
      };

      // Make the API request
      final response = await http.post(
        Uri.parse(submitRatingUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      final responseData = jsonDecode(response.body);

      if (kDebugMode) {
        print("Rating submission response: $responseData");
      }

      if (response.statusCode == 200 && responseData['status'] == 'success') {
        _showRatingSuccessDialog();
      } else {
        Get.snackbar(
            'Error'.tr,
            responseData['message'] ?? 'Failed to submit rating'.tr,
            snackPosition: SnackPosition.BOTTOM
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error submitting rating: $e");
      }
      Get.snackbar(
          'Error'.tr,
          'An error occurred while submitting your rating'.tr,
          snackPosition: SnackPosition.BOTTOM
      );
    }
  }

  // Function to check if booking is already rated
  Future<bool> checkIfAlreadyRated() async {
    try {
      // Get user ID from shared preferences
      final userId = myServices.sharedPreferences.getInt('id');

      // Make the API request
      final response = await http.get(
        Uri.parse('$checkRatingUrl?bookingId=$bookingId&user_id=$userId'),
        headers: {
          'Accept': 'application/json',
        },
      );

      final responseData = jsonDecode(response.body);

      if (kDebugMode) {
        print("Check rating response: $responseData");
      }

      if (response.statusCode == 200 && responseData['status'] == 'success') {
        return responseData['is_rated'] == true;
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print("Error checking if booking is rated: $e");
      }
      return false;
    }
  }

  void _showRatingSuccessDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 50,
              ),
              const SizedBox(height: 20),
              BigText(
                text: "Thank You!".tr,
                size: 18,
              ),
              const SizedBox(height: 15),
              SmallText(
                text: "Your feedback has been submitted successfully. We appreciate your time and input.".tr,
                textAlign: TextAlign.center,
                size: 14,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Close dialog
                  Get.offAllNamed(AppRoute.home); // Go to home screen
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                ),
                child: Text(
                  "Done".tr,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  @override
  void onClose() {
    // Clean up resources
    commentController.dispose();
    super.onClose();
  }}