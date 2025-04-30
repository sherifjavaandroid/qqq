import 'package:easycut/core/class/crud.dart';
import 'package:easycut/data/model/available_times.dart';
import 'package:easycut/linkapi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingData {
  final Crud crud;
  BookingData(this.crud);

  getData(String userId, String salonId) async {
    var response = await crud.postData(AppLink.showBooking, {
      "userid": userId,
      "salonid": salonId,
    });
    return response.fold((l) => l, (r) => r);
  }

  addsalonbooking(
    String salonId,
    String userId,
    String day,
    String startTime,
    String endTime,
    String chair,
    String total,
  ) async {
    var response = await crud.postData(AppLink.addBooking, {
      "salonid": salonId,
      "userid": userId,
      "day": day,
      "starttime": startTime,
      "endtime": endTime,
      "chair": chair,
      "total": total,
    });
    return response.fold((l) => l, (r) => r);
  }

  Future<List<String>> fetchAvailableTimes(
      String salonId, String date, List<String> serviceIds) async {
    if (salonId.isEmpty || date.isEmpty || serviceIds.isEmpty) return [];

    String serviceIdsQuery =
        serviceIds.map((id) => "service_ids[]=$id").join("&");
    String apiUrl =
        "${AppLink.viewAvaliableTimes}/$salonId?$serviceIdsQuery&date=$date";

    List<String> availableTimes = [];

    try {
      if (kDebugMode) {
        print("API Request: $apiUrl");
      }

      var response = await crud.getData(apiUrl);

      response.fold(
        (failure) {
          if (kDebugMode) {
            print("API Error: ${failure.toString()}");
          }
          Get.snackbar("Error".tr, "Failed to fetch available times".tr,
              colorText: Colors.red);
          return [];
        },
        (data) {
          final Map<String, dynamic> responseBody = data;

          if (kDebugMode) {
            print("Full Response Body: $responseBody");
          }

          if (responseBody['available'] == true) {
            final availableTimesModel =
                AvailableTimesModel.fromJson(responseBody);

            if (availableTimesModel.availableSlots != null &&
                availableTimesModel.availableSlots!.isNotEmpty) {
              availableTimes = availableTimesModel.availableSlots!
                  .map((slot) => slot.startTime ?? "Unknown Time")
                  .toList();
            } else {
              if (kDebugMode) {
                print("No available slots.");
              }
              Get.snackbar("Sorry".tr, "Salon is closed on this date".tr,
                  colorText: Colors.red);
            }
          } else {
            if (kDebugMode) {
              print("Response error: Invalid response structure.");
            }
            Get.snackbar("Sorry".tr, "Salon is closed on this date".tr,
                colorText: Colors.red);
          }
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print("Connection Error: $e");
      }
      Get.snackbar("Error".tr, "Connection error".tr, colorText: Colors.red);
    }

    return availableTimes;
  }

  Future<Map<String, dynamic>> submitBooking({
    required String salonId,
    required String userId,
    required String day,
    required String startTime,
    required String endTime,
    required String chair,
    required String total,
  }) async {
    var response = await crud.postData(AppLink.addBooking, {
      "salonid": salonId,
      "userid": userId,
      "day": day,
      "starttime": startTime,
      "endtime": endTime,
      "chair": chair,
      "total": total,
    });

    return response.fold((error) => {"status": "error"}, (data) => data);
  }
}
