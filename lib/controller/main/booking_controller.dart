import 'package:easycut/data/model/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easycut/core/class/status_request.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/services/services.dart';
import 'package:easycut/data/data_source/remote/main/booking_data.dart';
import 'package:easycut/data/data_source/remote/main/service_booking_data.dart';
import 'package:easycut/data/model/salon_model.dart';
import 'package:easycut/data/model/services_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BookingController extends GetxController {
  void chooseDate(String chosenDate);
  void chooseTime(String chosenTime);
  void chooseChair(int index);
  void chooseServices(ServiceModel service);
  Future<void> submitBooking();
}

Future<void> saveUserId(String userId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId);
}

class BookingControllerImp extends BookingController {
  SalonModel salon = SalonModel();
  List<ServiceModel> services = [];
  List<ProductModel> products = [];
  String userName = "";
  int? userId;
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.success;
  BookingData bookingData = BookingData(Get.find());
  BookingServiceData bookingServiceData = BookingServiceData(Get.find());
  List<String> bookedDates = [];
  List<String> availableTimes = [];

  void initialData() {
    salon = Get.arguments['salon'];
    services = Get.arguments['services'];
    userName = myServices.sharedPreferences.getString('name')!;
    userId = myServices.sharedPreferences.getInt('id')!;
    chosenServices = List<ServiceModel>.from(services);
  }

  @override
  void onInit() {
    initialData();
    // getBookedDates(); // Fetch booked dates when the controller initializes

    super.onInit();
  }

  int chair = 0;

  @override
  void chooseChair(int index) {
    chair = index;
    update();
  }

  String date = "Date".tr;

  @override
  void chooseDate(String chosenDate) async {
    if (chosenDate.isNotEmpty) {
      date = chosenDate;
      await fetchAvailableTimes(); // Fetch available times after selecting a date
      update();
    } else {
      Get.snackbar("Error".tr, "Invalid date selected.".tr,
          colorText: Colors.red);
    }
  }

  List<ServiceModel> chosenServices = [];

  @override
  void chooseServices(ServiceModel service) {
    if (chosenServices.contains(service)) {
      chosenServices.remove(service);
    } else {
      chosenServices.add(service);
    }
    fetchAvailableTimes(); // Fetch times whenever services change

    update();
  }

  String time = "Time".tr;

  @override
  void chooseTime(String chosenTime) {
    time = chosenTime;
    update();
  }

  Future<void> fetchAvailableTimes() async {
    availableTimes = await bookingData.fetchAvailableTimes(salon.id.toString(),
        date, chosenServices.map((s) => s.id.toString()).toList());

    if (availableTimes.isEmpty) {
      Get.snackbar("Sorry", "Salon is closed on this date",
          colorText: Colors.red);
    }
    update();
  }

  Future<void> submitBooking() async {
    if (date == "Date".tr || time == "Time".tr || chosenServices.isEmpty) {
      Get.snackbar(
        "Warning".tr,
        date == "Date".tr
            ? "Please, choose a date".tr
            : time == "Time".tr
                ? "Please, choose a time".tr
                : "Please, choose at least one service".tr,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
      return;
    }

    int endTime = chosenServices.fold(
        0, (sum, service) => sum + int.parse(service.time.toString()));
    int total = chosenServices.fold(
        0, (sum, service) => sum + int.parse(service.price.toString()));

    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await bookingData.submitBooking(
        salonId: salon.id.toString(),
        userId: userId.toString(),
        day: date,
        startTime: time,
        endTime: "$endTime",
        chair: (chair + 1).toString(),
        total: total.toString(),
      );

      if (response['status'] == 'success') {
        Get.snackbar(
          'Booking Successful'.tr,
          'Please wait until the salon accepts your booking'.tr,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.green,
        );
        Get.offNamed(AppRoute.successBooking, arguments: {
          "total": "$total",
          "start": time,
          "end": "$endTime",
          "day": date,
          "salon": salon.name,
          "chair": "${chair + 1}",
        });
      } else if (response['status'] == 'failure' &&
          response['message'] == 'Already Booked') {
        Get.snackbar(
          'Booking Error'.tr,
          'You already have a booking at this time. Please choose a different time or date.'
              .tr,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
        );
      } else {
        Get.snackbar(
          'Error'.tr,
          'Failed to save booking to API backend'.tr,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Error'.tr,
        'Booking submission failed'.tr,
        snackPosition: SnackPosition.TOP,
        colorText: Colors.red,
      );
      statusRequest = StatusRequest.failure;
    } finally {
      statusRequest = StatusRequest.success;
      update();
    }
  }
}
