import 'package:easycut/controller/onboarding_controller.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/data/data_source/static/static.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomSliderOnBoarding extends GetView<OnBoardingControllerImp> {
  const CustomSliderOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (val) {
        controller.onPageChanged(val);
      },
      itemCount: onBoardingList.length,
      itemBuilder: (context, i) {
        return Column(
          children: [
            SizedBox(height: 40.h),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 34.w, right: 34.w),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffF5F5F5),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  height: 333.h,
                  width: 364.w,
                  child: Image.asset(
                    onBoardingList[i].image!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            BigText(
              text: onBoardingList[i].title!,
              color: AppColor.primaryColor,
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.only(left: 38.w, right: 38.w),
              child: Container(
                width: 364.w,
                height: 175.h,
                decoration: BoxDecoration(
                    color: const Color(0xffF5F5F5),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColor.backgroundicons2)),
                child: Center(
                  child: SmallText(
                    maxline: 2,
                    size: 15.sp,
                    color: Colors.black,
                    text: onBoardingList[i].body!,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
