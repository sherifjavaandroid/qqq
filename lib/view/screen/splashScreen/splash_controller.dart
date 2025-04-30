import 'package:easycut/core/constant/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import 'package:easycut/core/services/services.dart';

import '../../../core/location_permission_helper.dart';
import '../../../core/location_services.dart';

class SplashController extends GetxController {
  var opacity = 0.0.obs;
  MyServices myServices = Get.find();
  late LocationServices locationServices;
  BuildContext? context;

  @override
  void onInit() {
    super.onInit();
    locationServices = Get.put(LocationServices());

    Future.delayed(const Duration(milliseconds: 500), () {
      opacity.value = 1.0;
    });

    Future.delayed(const Duration(seconds: 2), () async {
      // Request location permission
      if (context != null) {
        await LocationPermissionHelper.requestLocationPermission(context!);
      }

      // After a small delay, continue to the appropriate screen
      Future.delayed(const Duration(seconds: 1), () {
        _handleNavigation();
      });
    });
  }

  void setContext(BuildContext ctx) {
    context = ctx;
  }

  void _handleNavigation() {
    String? step = myServices.sharedPreferences.getString('step');
    if (step == '2') {
      Get.offNamed(AppRoute.home);
    } else if (step == '1') {
      Get.offNamed(AppRoute.languagescreen);
    } else {
      Get.offNamed(AppRoute.languagescreen); // Default redirection
    }
  }
}