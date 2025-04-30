import 'package:easycut/core/class/status_request.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/functions/handling_data_controller.dart';
import 'package:easycut/core/services/services.dart';
import 'package:easycut/data/data_source/remote/home/profile_data.dart';
import 'package:easycut/data/model/favorite_model.dart';
import 'package:easycut/data/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ProfileController extends GetxController {
  getData();
  logout();
  deleteAccount();
}

class ProfileControllerImp extends ProfileController
    with GetSingleTickerProviderStateMixin {
  MyServices myServices = Get.find();
  int? id;

  ProfileData profileData = ProfileData(Get.find());
  StatusRequest statusRequest = StatusRequest.loading;
  ProfileModel profile = ProfileModel();
  List<FavoriteModel> favorites = [];

  TabController? tabController; // Nullable to prevent LateInitializationError
  int selectedIndex = 0; // Track selected tab

  @override
  void onInit() {
    super.onInit();
    initialData();
    // Create tab controller after the dependent data is loaded
    tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        selectedIndex = tabController!.index;
        update();
      });
    getData();
  }

  void initialData() {
    id = myServices.sharedPreferences.getInt('id');
    // Set initial values to avoid null checks
    profile = ProfileModel(
        name: "Guest",
        email: "guest@example.com",
        country: "",
        city: "",
        address: "",
        phone: "",
        image: ""
    );
  }

  @override
  getData() async {
    if (id == null) {
      // Handle guest mode gracefully
      statusRequest = StatusRequest.success;
      update();
      return;
    }

    try {
      statusRequest = StatusRequest.loading;
      update();

      var response = await profileData.postData(id.toString());
      statusRequest = handlingData(response);

      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          // Parse profile data
          if (response['profile'] != null) {
            var data = response['profile'] as Map<String, dynamic>;
            profile = ProfileModel.fromJson(data);
          }

          // Parse favorites data with error handling
          if (response['favorites'] != null && response['favorites'] is List) {
            try {
              favorites = FavoriteModel.fromList(
                  List<Map<String, dynamic>>.from(response['favorites']));
            } catch (e) {
              print('Error parsing favorites: $e');
              favorites = [];
            }
          } else {
            favorites = [];
          }
        } else {
          Get.snackbar(
            'Warning'.tr,
            'Failed to load profile data'.tr,
            snackPosition: SnackPosition.TOP,
            colorText: Colors.red,
          );
          statusRequest = StatusRequest.failure;
        }
      }
    } catch (e) {
      print('Error in profile getData: $e');
      statusRequest = StatusRequest.serverException;
    }

    update();
  }

  @override
  void onClose() {
    tabController?.dispose();
    super.onClose();
  }

  @override
  logout() {
    Get.offAllNamed(AppRoute.login);
    myServices.sharedPreferences.clear();
    myServices.sharedPreferences.setString('step', '1');
  }

  @override
  deleteAccount() {
    Get.defaultDialog(
      middleText: "Are you sure to delete your account?".tr,
      actions: [
        TextButton(
          onPressed: () async {
            Get.back();
            try {
              statusRequest = StatusRequest.loading;
              update();

              // Only attempt to delete if we have a valid ID and image
              if (id != null) {
                var response = await profileData.deleteData(
                  id.toString(),
                  profile.image ?? '',
                );

                statusRequest = handlingData(response);

                if (statusRequest == StatusRequest.success) {
                  if (response['status'] == 'success') {
                    logout();
                  } else {
                    Get.snackbar(
                      'Warning'.tr,
                      'Failed to Delete Account, Try Again'.tr,
                      snackPosition: SnackPosition.TOP,
                      colorText: Colors.red,
                    );
                    statusRequest = StatusRequest.failure;
                  }
                }
              } else {
                Get.snackbar(
                  'Warning'.tr,
                  'Account ID not found'.tr,
                  snackPosition: SnackPosition.TOP,
                  colorText: Colors.red,
                );
                statusRequest = StatusRequest.failure;
              }
            } catch (e) {
              print('Error in deleteAccount: $e');
              statusRequest = StatusRequest.serverException;
              Get.snackbar(
                'Error'.tr,
                'Failed to connect to server'.tr,
                snackPosition: SnackPosition.TOP,
                colorText: Colors.red,
              );
            }
            update();
          },
          child: Text("yes".tr, style: const TextStyle(color: Colors.red)),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text("no".tr, style: const TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}