import 'dart:convert';
import 'package:easycut/data/data_source/remote/home/home_data.dart';
import 'package:easycut/data/model/feeddbackrates.dart';
import 'package:easycut/data/model/home_model.dart';
import 'package:http/http.dart' as http;

import 'package:dartz/dartz.dart';
import 'package:easycut/core/class/status_request.dart';
import 'package:easycut/core/functions/handling_data_controller.dart';
import 'package:easycut/core/services/services.dart';
import 'package:easycut/data/data_source/remote/main/salon_detail_data.dart';
import 'package:easycut/data/model/comment_model.dart';
import 'package:easycut/data/model/products_model.dart';
import 'package:easycut/data/model/salon_model.dart';
import 'package:easycut/data/model/services_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class SalonDetailController extends GetxController {
  Future<void> getSalonDetail();
  Future<void> addToFavorites();
  Future<void> deleteFromFavorites();
  Future<void> changeFavoriteState();
  bool get isLoggedIn;
}

class SalonDetailControllerImp extends SalonDetailController {
  int? salonId;
  int? userId;
  bool? isFavorite;
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.success;
  SalonDetailData salonDetail = SalonDetailData(Get.find());
  SalonModel salon = SalonModel();
  List<ServiceModel> services = [];
  List<ProductModel> products = [];
  List<CommentModel> comments = [];
  List<SalonModel> allSalons = [];
  var currentRating = 0.0.obs;
  final Set<int> selectedIndices = {};
  final HomeData homeData = HomeData(Get.find());

  @override
  void onInit() {
    salonId = Get.arguments['salonid'];
    userId = myServices.sharedPreferences.getInt('id');
    isFavorite = false;
    getSalonDetail();
    super.onInit();
  }

  bool isSelected(int index) => selectedIndices.contains(index);
  List<ServiceModel> get selectedServices =>
      selectedIndices.map((index) => services![index]).toList();
  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
    update();
  }

  @override
  Future<void> getSalonDetail() async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await salonDetail.getData(
        salonId.toString(),
        userId?.toString() ?? '',
      );

      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success &&
          response['status'] == 'success') {
        isFavorite = response['favorite'];

        var data = response['salon'] as Map<String, dynamic>;

        // Safely handle salon image URL
        String? salonImage =
            data['image']?.isNotEmpty == true ? data['image'] : null;

        salon = SalonModel.fromJson({...data, 'image': salonImage});

        // Clear previous lists to prevent duplication
        services.clear();
        products.clear();
        comments.clear();

        // Populate services
        services = (response['services'] as List?)
                ?.map((item) => ServiceModel.fromJson(item))
                .toList() ??
            [];

        // Populate products
        products = (response['products'] as List?)
                ?.map((item) => ProductModel.fromJson(item))
                .toList() ??
            [];

        // Populate comments
        comments = (response['comments'] as List?)
                ?.map((item) => CommentModel.fromJson(item))
                .toList() ??
            [];
      } else {
        _showSnackBar('Warning'.tr, 'No data available'.tr);
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      _showSnackBar('Error'.tr, 'Failed to load data. Please try again.'.tr);
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  @override
  Future<void> addToFavorites() async {
    await _toggleFavoriteStatus(
      action: () =>
          salonDetail.postData(salonId.toString(), userId?.toString() ?? ''),
      successMessage: 'Added to your Favorites'.tr,
    );
  }

  @override
  Future<void> deleteFromFavorites() async {
    await _toggleFavoriteStatus(
      action: () =>
          salonDetail.deleteData(salonId.toString(), userId?.toString() ?? ''),
      successMessage: 'Removed from your Favorites'.tr,
    );
  }

  Future<void> _toggleFavoriteStatus({
    required Future<dynamic> Function() action,
    required String successMessage,
  }) async {
    statusRequest = StatusRequest.loading;
    update();

    try {
      var response = await action();
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success &&
          response['status'] == 'success') {
        _showSnackBar('Success'.tr, successMessage, color: Colors.green);
      } else {
        _showSnackBar('Warning'.tr, 'Action failed.'.tr);
        statusRequest = StatusRequest.failure;
      }
    } catch (e) {
      _showSnackBar(
          'Error'.tr, 'Failed to perform action. Please try again.'.tr);
      statusRequest = StatusRequest.failure;
    }
    update();
  }

  @override
  Future<void> changeFavoriteState() async {
    isFavorite = !isFavorite!;
    if (isFavorite!) {
      await addToFavorites();
    } else {
      await deleteFromFavorites();
    }
  }

  // Helper method to display snackbars
  void _showSnackBar(String title, String message,
      {Color color = Colors.green}) {
    Get.snackbar(
      title.tr,
      message.tr,
      snackPosition: SnackPosition.TOP,
      colorText: color,
    );
  }

  // Helper method to build the salon image widget with fallback
  Widget buildSalonImage(String? imageUrl) {
    return Image.network(
      imageUrl ?? 'assets/images/salonbk/salon1.jpg',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        if (kDebugMode) {
          print('Image load failed: $error');
        }
        return Image.asset(
          'assets/images/salonbk/salon1.jpg',
          fit: BoxFit.cover,
        );
      },
    );
  }

  Future<void> feedbackSalonRating(int salonId, double newRating) async {
    if (userId == null) {
      _showSnackBar('Warning'.tr, 'User not logged in'.tr);
      return;
    }

    currentRating.value = newRating;
    String ratingAsInt = newRating.round().toString();

    try {
      final response =
          await homeData.feedbackSalonRating(salonId, ratingAsInt, userId);
      if (response['message'] == 'success') {
        Feeddbackrates feeddbackrates = Feeddbackrates.fromJson(response);
        _showSnackBar('Success'.tr, 'Rating submitted successfully!'.tr,
            color: Colors.green);
        if (kDebugMode) {
          print("Rating submitted successfully: $response");
        }
        if (kDebugMode) {
          print("Salon Rating: ${feeddbackrates.rating?.rating}");
        }
      } else {
        if (kDebugMode) {
          print("Failed to fetch rating: ${response['message']}");
        }
      }
    } catch (e) {
      _showSnackBar('Success'.tr, 'Rating submitted successfully!'.tr,
          color: Colors.green);
      if (kDebugMode) {
        print("Error fetching rating: $e");
      }
    }
  }

  @override
  bool get isLoggedIn => userId != null;
}
