import 'package:easycut/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController controller = Get.put(SplashController());
    // Pass context to controller
    controller.setContext(context);

    return Scaffold(
      backgroundColor: AppColor.selectedColor,
      body: Center(
        child: Obx(
              () => AnimatedOpacity(
            duration: const Duration(seconds: 5),
            opacity: controller.opacity.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 348.h,
                  width: 348.w,
                  child: Image.asset(
                    'assets/images/icon/logo.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  maxLines: 1,
                  'Your Salon is on your Phone',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'calligraffitti',
                    color: const Color(0xffD72323),
                    height: 1.96.h,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}