import 'package:easycut/controller/onboarding_controller.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButtonOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomButtonOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: const EdgeInsets.only(bottom: 30),
      child: MaterialButton(
        onPressed: () {
          controller.next();
        },
        padding: const EdgeInsets.symmetric(
          horizontal: 100,
        ),
        color: AppColor.primaryColor,
        textColor: Colors.white,
        child: Text(
          "continue".tr,
        ),
      ),
    );
  }
}
