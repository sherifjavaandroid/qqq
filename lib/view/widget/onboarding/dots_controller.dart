import 'package:easycut/controller/onboarding_controller.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/data/data_source/static/static.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDotControllerOnBoarding extends StatelessWidget {
  const CustomDotControllerOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingControllerImp>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...List.generate(
              onBoardingList.length,
              (index) {
                return AnimatedContainer(
                  margin: const EdgeInsets.only(right: 5),
                  duration: const Duration(milliseconds: 600),
                  width: controller.currentPage == index ? 20 : 5,
                  height: 6,
                  decoration: BoxDecoration(
                    color: controller.currentPage == index
                        ? AppColor.iconColor1
                        : AppColor.backgroundicons2,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
