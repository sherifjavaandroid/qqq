import 'package:easycut/core/class/status_request.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/functions/handling_data_controller.dart';
import 'package:easycut/data/data_source/remote/forget_password/reset_password.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ResetPasswordController extends GetxController {
  resetPassword();
}

class ResetPasswordControllerImp extends ResetPasswordController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String? email;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  ResetPasswordData resetPasswordData = ResetPasswordData(Get.find());
  StatusRequest statusRequest = StatusRequest.success;

  bool isShowPassword = true;

  showPassword() {
    isShowPassword = !isShowPassword;
    update();
  }

  @override
  resetPassword() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      if (password.text == confirmPassword.text) {
        statusRequest = StatusRequest.loading;
        update();
        var response = await resetPasswordData.postData(
          email!,
          password.text,
        );
        statusRequest = handlingData(response);
        if (statusRequest == StatusRequest.success) {
          if (response['status'] == 'success') {
            // data.addAll(response['data']);
            Get.snackbar(
              'Success'.tr,
              'Password Change Successfully'.tr,
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.green,
            );
            Get.offAllNamed(AppRoute.success);
          } else {
            Get.snackbar(
              'Warning'.tr,
              'please choose a Strong Password'.tr,
              snackPosition: SnackPosition.TOP,
              colorText: Colors.red,
            );
            statusRequest = StatusRequest.failure;
          }
        }
        update();
      } else {
        Get.snackbar(
          "Warning".tr,
          "New Password is not Equal to Confirm Password".tr,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
        );
      }
    } else {}
  }

  @override
  void onInit() {
    email = Get.arguments['email'];
    password = TextEditingController();
    confirmPassword = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }
}
