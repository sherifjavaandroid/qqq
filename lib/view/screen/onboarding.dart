import 'package:easycut/app.dart';
import 'package:easycut/controller/onboarding_controller.dart';
import 'package:easycut/view/widget/auth/custom_button_auth.dart';
import 'package:easycut/view/widget/onboarding/custom_button.dart';
import 'package:easycut/view/widget/onboarding/custom_slider.dart';
import 'package:easycut/view/widget/onboarding/dots_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnBoarding extends GetView<OnBoardingControllerImp> {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 5,
              child: CustomSliderOnBoarding(),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  const CustomDotControllerOnBoarding(),
                  CustomButtonAuth(
                    onPressed: () {
                      controller.next();
                    },
                    text: "continue".tr,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
