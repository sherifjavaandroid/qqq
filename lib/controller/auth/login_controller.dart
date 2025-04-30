import 'package:easycut/core/class/status_request.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/functions/handling_data_controller.dart';
import 'package:easycut/core/services/services.dart';
import 'package:easycut/data/data_source/remote/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../view/screen/auth/signup.dart';

abstract class LoginController extends GetxController {
  login();
  goToForgetPassword();
  goToSignUp();
}

class LoginControllerImp extends LoginController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController email;
  late TextEditingController password;
  LoginData loginData = LoginData(Get.find());
  StatusRequest statusRequest = StatusRequest.success;
  bool isShowPassword = true;
  MyServices myServices = Get.find();
  bool _isNavigating = false;
  showPassword() {
    isShowPassword = !isShowPassword;
    update();
  }

  @override
  goToForgetPassword() {
    Get.toNamed(AppRoute.forgetPassword);
  }
  @override
  goToSignUp() {
    // Simple straightforward approach
    try {
      // Use a synchronous method to avoid conflicts
      Get.to(() => const SignUp(),
          transition: Transition.rightToLeft,
          duration: Duration(milliseconds: 500),
          preventDuplicates: true);
    } catch (e) {
      print("Navigation error: $e");
    }
  }

  @override
  login() async {
    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      update();
      var response = await loginData.postData(email.text, password.text);
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          if (response['data']['approve'] != '1') {
            Get.snackbar(
              'Congratulation'.tr,
              'You information is correct \nWait for loading Data.'.tr,
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.green,
            );
            Get.offAllNamed(AppRoute.home);

            myServices.sharedPreferences
                .setString('userId', response['data']['id'].toString());
            myServices.sharedPreferences.setInt('id', response['data']['id']);
            myServices.sharedPreferences
                .setString('name', response['data']['name']);
            myServices.sharedPreferences
                .setString('gender', response['data']['gender']);
            myServices.sharedPreferences
                .setString('country', response['data']['country']);
            myServices.sharedPreferences
                .setString('city', response['data']['city']);
            myServices.sharedPreferences
                .setString('image', response['data']['image']);

            myServices.sharedPreferences.setString('step', '2');
          } else {
            Get.toNamed(AppRoute.activateCode, arguments: {
              "email": email.text,
            });
          }
        } else {
          Get.snackbar(
            'Warning'.tr,
            'Your information is incorrect'.tr,
            snackPosition: SnackPosition.TOP,
            colorText: Colors.red,
          );
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    } else {}
  }

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }
}
