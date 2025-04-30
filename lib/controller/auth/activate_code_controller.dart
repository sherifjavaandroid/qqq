import 'package:easycut/core/class/status_request.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/functions/handling_data_controller.dart';
import 'package:easycut/data/data_source/remote/auth/activate_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ActivateCodeController extends GetxController {
  checkCode(String val);
}

class ActivateCodeControllerImp extends ActivateCodeController {
  String? email;

  ActivateCodeData activateCodeData = ActivateCodeData(Get.find());
  StatusRequest statusRequest = StatusRequest.success;

  @override
  checkCode(String val) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await activateCodeData.postData(
      email!,
      val,
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        // data.addAll(response['data']);
        Get.snackbar(
          'Congratulation'.tr,
          'Your verify code is correct'.tr,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.green,
        );
        Get.toNamed(AppRoute.success);
      } else {
        Get.snackbar(
          'Warning'.tr,
          'Your code is incorrect'.tr,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
        );
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }
}
