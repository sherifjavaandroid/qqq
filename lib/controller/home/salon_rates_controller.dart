import 'package:easycut/data/data_source/remote/home/home_data.dart';
import 'package:easycut/data/model/salonrates.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class SalonRatesController extends GetxController {
  final HomeData homeData = HomeData(Get.find());

  var salonRatings = <int, double>{}.obs;
  var loadingSalons = <int, bool>{}.obs;

  Future<void> fetchRating(int salonId) async {
    if (loadingSalons[salonId] == true) return;

    loadingSalons[salonId] = true;
    update();

    try {
      await Future.wait([
        Future.delayed(
            const Duration(milliseconds: 1)), // Ensure 1-second loading
        _fetchRatingFromApi(salonId), // API call inside Future.wait
      ]);
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching rating for Salon $salonId: $e");
      }
    } finally {
      loadingSalons[salonId] = false;
      update();
    }
  }

  Future<void> _fetchRatingFromApi(int salonId) async {
    final response = await homeData.getsalonRating(salonId);

    if (response['status'] == 'success') {
      SalonratesModel salonRates = SalonratesModel.fromJson(response);
      salonRatings[salonId] =
          double.tryParse(salonRates.data?.averageRating.toString() ?? '0') ??
              0.0;
    } else {
      if (kDebugMode) {
        print(
            "Failed to fetch rating for Salon $salonId: ${response['message']}");
      }
    }
  }
}
