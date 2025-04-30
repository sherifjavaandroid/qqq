import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/services/services.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/data_source/remote/home/book_op.dart';

class BookingCancellationController extends GetxController {
  final int bookingId;
  final String bookingDay;
  final String bookingTime;

  // Observables for UI updates
  final remainingTimeText = "".obs;
  final isCloseToDeadline = false.obs;

  // Services
  final MyServices myServices = Get.find();
  late BookingOperationsData bookingOperations;

  // Properties
  bool canCancel = false;
  bool canReschedule = false;
  String cancellationDeadline = "";
  int? salonId;

  // API endpoints
  final String cancelBookingUrl = "https://dashboard.easycuteg.com/api/v1/auth/booking/cancel";

  BookingCancellationController({
    required this.bookingId,
    required this.bookingDay,
    required this.bookingTime,
  }) {
    bookingOperations = BookingOperationsData(Get.find());
  }

  @override
  void onInit() {
    super.onInit();
    _initializeController();
    // Start timer to update remaining time
    _startRemainingTimeTimer();
  }

  void _initializeController() {
    _checkCancellationEligibility();
    _fetchBookingDetails();
  }

  void _fetchBookingDetails() async {
    try {
      final response = await bookingOperations.getBookingDetails(bookingId);
      if (kDebugMode) {
        print("Booking details response: $response");
      }

      if (response != null && response['status'] == 'success') {
        // Parse response data
        if (response['data'] != null) {
          final bookingData = response['data'];
          salonId = bookingData['salon_id'];

          if (kDebugMode) {
            print("Salon ID: $salonId");
          }
        }
      } else {
        Get.snackbar(
            'Error'.tr,
            'Failed to load booking details'.tr,
            snackPosition: SnackPosition.BOTTOM
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching booking details: $e");
      }
    }
    update();
  }

  void _checkCancellationEligibility() {
    try {
      // Parse booking date and time
      final dateFormat = DateFormat('yyyy-MM-dd');
      final timeFormat = DateFormat('HH:mm');

      if (kDebugMode) {
        print("Checking eligibility for day: $bookingDay, time: $bookingTime");
      }

      final bookingDate = dateFormat.parse(bookingDay);

      // Handle different time formats
      DateTime bookingDateTime;
      try {
        final timeParts = bookingTime.split(':');
        final bookingTimeObj = TimeOfDay(
          hour: int.parse(timeParts[0]),
          minute: int.parse(timeParts[1].split(' ').first),
        );

        // Create booking datetime
        bookingDateTime = DateTime(
          bookingDate.year,
          bookingDate.month,
          bookingDate.day,
          bookingTimeObj.hour,
          bookingTimeObj.minute,
        );
      } catch (e) {
        // Alternative parsing if the first method fails
        try {
          final timeObj = timeFormat.parse(bookingTime);
          bookingDateTime = DateTime(
            bookingDate.year,
            bookingDate.month,
            bookingDate.day,
            timeObj.hour,
            timeObj.minute,
          );
        } catch (e2) {
          // Fallback to a default time if all parsing fails
          bookingDateTime = DateTime(
            bookingDate.year,
            bookingDate.month,
            bookingDate.day,
            12, 0, // Default to noon
          );

          if (kDebugMode) {
            print("Error parsing time, using default: $e2");
          }
        }
      }

      if (kDebugMode) {
        print("Booking date time: $bookingDateTime");
      }

      // Calculate cancellation deadline (6 hours before appointment)
      final cancellationDeadlineTime = bookingDateTime.subtract(const Duration(hours: 6));

      // Format for display
      final displayFormat = DateFormat('EEE, MMM d, yyyy - hh:mm a');
      cancellationDeadline = displayFormat.format(cancellationDeadlineTime);

      // Check if current time is before the cancellation deadline
      final currentTime = DateTime.now();
      canCancel = currentTime.isBefore(cancellationDeadlineTime);

      // Can reschedule if cancellation is allowed
      canReschedule = canCancel;

      // Update remaining time text
      _updateRemainingTimeText(cancellationDeadlineTime);

      if (kDebugMode) {
        print("Can cancel: $canCancel");
        print("Can reschedule: $canReschedule");
        print("Cancellation deadline: $cancellationDeadline");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error checking cancellation eligibility: $e");
        print("Booking day: $bookingDay, Booking time: $bookingTime");
      }

      // Set default values on error
      canCancel = false;
      canReschedule = false;
    }
    update();
  }

  void _updateRemainingTimeText(DateTime deadline) {
    final now = DateTime.now();

    if (now.isAfter(deadline)) {
      remainingTimeText.value = "Deadline passed".tr;
      isCloseToDeadline.value = true;
      return;
    }

    final difference = deadline.difference(now);

    // Format the remaining time
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;

    if (hours > 0) {
      remainingTimeText.value = "$hours ${"hours".tr} $minutes ${"minutes".tr} ${"remaining".tr}";
    } else {
      remainingTimeText.value = "$minutes ${"minutes".tr} ${"remaining".tr}";
    }

    // Set warning flag if less than 1 hour remaining
    isCloseToDeadline.value = hours < 1;
  }

  void _startRemainingTimeTimer() {
    // Update the remaining time every minute
    Future.delayed(const Duration(minutes: 1), () {
      try {
        // Parse booking date and time
        final dateFormat = DateFormat('yyyy-MM-dd');

        final bookingDate = dateFormat.parse(bookingDay);
        DateTime bookingDateTime;

        // Try different methods to parse the time
        try {
          final timeParts = bookingTime.split(':');
          final bookingTimeObj = TimeOfDay(
            hour: int.parse(timeParts[0]),
            minute: int.parse(timeParts[1].split(' ').first),
          );

          // Create booking datetime
          bookingDateTime = DateTime(
            bookingDate.year,
            bookingDate.month,
            bookingDate.day,
            bookingTimeObj.hour,
            bookingTimeObj.minute,
          );
        } catch (e) {
          // Fallback parsing
          final timeFormat = DateFormat('HH:mm');
          try {
            final timeObj = timeFormat.parse(bookingTime);
            bookingDateTime = DateTime(
              bookingDate.year,
              bookingDate.month,
              bookingDate.day,
              timeObj.hour,
              timeObj.minute,
            );
          } catch (e2) {
            // Last resort fallback
            bookingDateTime = DateTime(
              bookingDate.year,
              bookingDate.month,
              bookingDate.day,
              12, 0, // Default to noon
            );
          }
        }

        // Calculate cancellation deadline
        final cancellationDeadlineTime = bookingDateTime.subtract(const Duration(hours: 6));

        // Update remaining time text
        _updateRemainingTimeText(cancellationDeadlineTime);

        // Continue timer if still before deadline
        if (DateTime.now().isBefore(cancellationDeadlineTime)) {
          _startRemainingTimeTimer();
        }
      } catch (e) {
        if (kDebugMode) {
          print("Error updating remaining time: $e");
        }
      }
    });
  }

  Future<void> cancelBooking() async {
    if (!canCancel) {
      Get.snackbar(
          'Error'.tr,
          'This booking cannot be cancelled'.tr,
          snackPosition: SnackPosition.BOTTOM
      );
      return;
    }

    try {
      // Get user ID from shared preferences
      final userId = myServices.sharedPreferences.getInt('id');

      // Make the direct API call to cancel the booking
      final response = await http.post(
        Uri.parse(cancelBookingUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'bookingId': bookingId,
          'user_id': userId,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (kDebugMode) {
        print("Cancel booking response: $responseData");
      }

      if (response.statusCode == 200 && responseData['status'] == 'success') {
        Get.snackbar(
            'Success'.tr,
            'Your booking has been cancelled successfully'.tr,
            snackPosition: SnackPosition.BOTTOM
        );

        // Navigate back to bookings page
        Get.offAllNamed(AppRoute.home);
      } else {
        Get.snackbar(
            'Error'.tr,
            responseData['message'] ?? 'Failed to cancel booking'.tr,
            snackPosition: SnackPosition.BOTTOM
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error cancelling booking: $e");
      }
      Get.snackbar(
          'Error'.tr,
          'An error occurred while cancelling your booking'.tr,
          snackPosition: SnackPosition.BOTTOM
      );
    }
  }

  @override
  void onClose() {
    // Clean up resources
    super.onClose();
  }
}