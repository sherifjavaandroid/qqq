import 'package:easycut/core/class/crud.dart';
import 'package:easycut/linkapi.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class BookingOperationsData {
  Crud crud;

  // API endpoints
  final String getBookingDetailsUrl = "https://dashboard.easycuteg.com/api/v1/auth/booking/details";
  final String getBookingServicesUrl = "https://dashboard.easycuteg.com/api/v1/auth/booking/services";
  final String cancelBookingUrl = "https://dashboard.easycuteg.com/api/v1/auth/booking/cancel";
  final String rescheduleBookingUrl = "https://dashboard.easycuteg.com/api/v1/auth/booking/reschedule";
  final String checkRatingUrl = "https://dashboard.easycuteg.com/api/v1/auth/rating/check";
  final String submitRatingUrl = "https://dashboard.easycuteg.com/api/v1/auth/rating/submit";

  BookingOperationsData(this.crud);

  // Get booking details
  Future<Map<String, dynamic>?> getBookingDetails(int bookingId) async {
    try {
      final response = await http.get(
        Uri.parse('$getBookingDetailsUrl?bookingId=$bookingId'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        if (kDebugMode) {
          print("Error getting booking details: ${response.statusCode}");
          print("Response body: ${response.body}");
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception getting booking details: $e");
      }
      return null;
    }
  }

  // Get booking services
  Future<Map<String, dynamic>?> getBookingServices(int bookingId) async {
    try {
      final response = await http.get(
        Uri.parse('$getBookingServicesUrl?bookingId=$bookingId'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        if (kDebugMode) {
          print("Error getting booking services: ${response.statusCode}");
          print("Response body: ${response.body}");
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception getting booking services: $e");
      }
      return null;
    }
  }

  // Cancel booking
  Future<Map<String, dynamic>?> cancelBooking(int bookingId, [int? userId]) async {
    try {
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

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        if (kDebugMode) {
          print("Error cancelling booking: ${response.statusCode}");
          print("Response body: ${response.body}");
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception cancelling booking: $e");
      }
      return null;
    }
  }

  // Reschedule booking
  Future<Map<String, dynamic>?> rescheduleBooking({
    required int bookingId,
    required String newDate,
    required String newTime,
    int? userId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(rescheduleBookingUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'bookingId': bookingId,
          'user_id': userId,
          'newDate': newDate,
          'newTime': newTime,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        if (kDebugMode) {
          print("Error rescheduling booking: ${response.statusCode}");
          print("Response body: ${response.body}");
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception rescheduling booking: $e");
      }
      return null;
    }
  }

  // Check if booking is rated
  Future<bool> checkBookingRated(int bookingId, [int? userId]) async {
    try {
      final response = await http.get(
        Uri.parse('$checkRatingUrl?bookingId=$bookingId&user_id=$userId'),
        headers: {
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['status'] == 'success') {
          return responseData['is_rated'] == true;
        }
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print("Exception checking if booking is rated: $e");
      }
      return false;
    }
  }

  // Submit booking rating
  Future<Map<String, dynamic>?> submitBookingRating({
    required int bookingId,
    required int serviceQuality,
    required int cleanliness,
    required int customerService,
    String? comment,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(submitRatingUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'bookingId': bookingId,
          'serviceQuality': serviceQuality,
          'cleanliness': cleanliness,
          'customerService': customerService,
          'comment': comment ?? '',
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        if (kDebugMode) {
          print("Error submitting booking rating: ${response.statusCode}");
          print("Response body: ${response.body}");
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Exception submitting booking rating: $e");
      }
      return null;
    }
  }
}