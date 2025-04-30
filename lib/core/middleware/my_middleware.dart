import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/services/services.dart';

class MyMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  MyServices myServices = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    String? step = myServices.sharedPreferences.getString('step');
    if (step == '2') {
      return const RouteSettings(name: AppRoute.home);
    }
    if (step == '1') {
      return const RouteSettings(name: AppRoute.home);
    }
    return null; // Stay on splash screen if step is not defined
  }
}
