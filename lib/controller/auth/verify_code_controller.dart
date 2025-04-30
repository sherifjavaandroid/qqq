import 'package:easycut/core/class/status_request.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/functions/handling_data_controller.dart';
import 'package:easycut/data/data_source/remote/forget_password/verify_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class VerifyCodeController extends GetxController {
  checkCode(String val);
}

class VerifyCodeControllerImp extends VerifyCodeController {
  VerifyCodeData verifyCodeData = VerifyCodeData(Get.find());
  StatusRequest statusRequest = StatusRequest.success;

  String? email;

  @override
  checkCode(String val) async {
    // Set the status to loading to show a loading indicator in the UI
    statusRequest = StatusRequest.loading;
    update();

    // Simulate sending the verification request
    var response = await verifyCodeData.postData(
      email!, // The user's email
      val, // The verification code entered
    );

    // Handle the response data
    statusRequest = handlingData(response);

    // If the request was successful
    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        // If the verification code is correct
        Get.snackbar(
          'Congratulation'.tr, // Snackbar title
          'Your verify code is correct'.tr, // Success message
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to the reset password screen
        Get.toNamed(AppRoute.resetPassword, arguments: {
          'email': email,
        });
      } else {
        // If the verification code is incorrect
        Get.snackbar(
          'Warning'.tr, // Snackbar title
          'Your code is incorrect'.tr, // Warning message
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );

        // Set the status to failure to show failure state in UI
        statusRequest = StatusRequest.failure;
      }
    }

    // Ensure the UI is updated after the verification attempt
    update();
  }

  @override
  void onInit() {
    email =
        Get.arguments['email']; // Initialize the email from passed arguments
    super.onInit();
  }
}
