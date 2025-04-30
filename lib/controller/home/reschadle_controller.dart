import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/services/services.dart';
import 'package:easycut/data/data_source/remote/main/booking_data.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/data_source/remote/home/book_op.dart';

class RescheduleBookingController extends GetxController {
  final int bookingId;
  final int salonId;

  // Services
  final MyServices myServices = Get.find();
  late BookingOperationsData bookingOperations;
  late BookingData bookingData;

  // State variables
  bool isLoading = false;
  String? selectedDate;
  String? selectedTimeSlot;
  List<String> availableTimeSlots = [];

  // API endpoint
  final String rescheduleBookingUrl = "https://dashboard.easycuteg.com/api/v1/auth/booking/reschedule";

  bool get canReschedule => selectedDate != null && selectedTimeSlot != null;

  RescheduleBookingController({
    required this.bookingId,
    required this.salonId,
  }) {
    bookingOperations = BookingOperationsData(Get.find());
    bookingData = BookingData(Get.find());
    if (kDebugMode) {
      print(
          "RescheduleBookingController initialized with bookingId: $bookingId, salonId: $salonId");
    }
  }

  void setSelectedDate(DateTime date) {
    // Format date for display and API
    final formatter = DateFormat('yyyy-MM-dd');
    selectedDate = formatter.format(date);

    // Clear previously selected time slot
    selectedTimeSlot = null;

    // Fetch available time slots for this date
    fetchAvailableTimeSlots();
    update();
  }

  void selectTimeSlot(String timeSlot) {
    selectedTimeSlot = timeSlot;
    update();
  }

  Future<void> fetchAvailableTimeSlots() async {
    if (selectedDate == null) return;

    isLoading = true;
    update();

    try {
      // Get user ID from shared preferences
      final userId = myServices.sharedPreferences.getString('userId');

      // Fetch services associated with this booking to calculate duration
      final serviceIds = await _getBookingServiceIds();

      if (kDebugMode) {
        print("Service IDs for booking: $serviceIds");
      }

      if (serviceIds.isEmpty) {
        if (kDebugMode) {
          print("No services found for this booking");
        }
        availableTimeSlots = [];
        isLoading = false;
        update();
        return;
      }

      // Fetch available time slots from API
      availableTimeSlots = await bookingData.fetchAvailableTimes(
        salonId.toString(),
        selectedDate!,
        serviceIds,
      );

      if (kDebugMode) {
        print("Available time slots: $availableTimeSlots");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching available time slots: $e");
      }

      // Clear available time slots in case of error
      availableTimeSlots = [];

      // Show error message
      Get.snackbar('Error'.tr, 'Failed to load available time slots'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<List<String>> _getBookingServiceIds() async {
    try {
      final response = await bookingOperations.getBookingServices(bookingId);

      if (kDebugMode) {
        print("Booking services response: $response");
      }

      if (response != null && response['status'] == 'success') {
        if (response['services'] != null && response['services'] is List) {
          return (response['services'] as List)
              .map((service) => service['service_id'].toString())
              .toList();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching booking services: $e");
      }
    }

    return [];
  }

  Future<void> rescheduleBooking() async {
    if (!canReschedule) {
      Get.snackbar('Error'.tr, 'Please select both date and time'.tr,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    isLoading = true;
    update();

    try {
      if (kDebugMode) {
        print(
            "Rescheduling booking $bookingId to date: $selectedDate, time: $selectedTimeSlot");
      }

      // Get user ID from shared preferences
      final userId = myServices.sharedPreferences.getInt('id');

      // Make the direct API call to reschedule the booking
      final response = await http.post(
        Uri.parse(rescheduleBookingUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'bookingId': bookingId,
          'user_id': userId,
          'newDate': selectedDate,
          'newTime': selectedTimeSlot,
        }),
      );

      final responseData = jsonDecode(response.body);

      if (kDebugMode) {
        print("Reschedule response: $responseData");
      }

      if (response.statusCode == 200 && responseData['status'] == 'success') {
        Get.snackbar(
            'Success'.tr, 'Your booking has been rescheduled successfully'.tr,
            snackPosition: SnackPosition.BOTTOM);

        // Navigate back to bookings page
        Get.offAllNamed(AppRoute.home);
      } else {
        Get.snackbar('Error'.tr,
            responseData['message'] ?? 'Failed to reschedule booking'.tr,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error rescheduling booking: $e");
      }
      Get.snackbar(
          'Error'.tr, 'An error occurred while rescheduling your booking'.tr,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading = false;
      update();
    }
  }
}