import 'package:easycut/controller/home/home_controller.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SalonClassificationFilter extends StatelessWidget {
  const SalonClassificationFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeControllerImp>(
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 38.w, vertical: 10.h),
          child: Container(
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColor.backgroundButton,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: AppColor.backgroundicons2, width: 1.w),
            ),
            child: Row(
              children: [
                Expanded(
                  child: _buildFilterOption(
                    context: context,
                    title: "All".tr,
                    value: "all",
                    controller: controller,
                  ),
                ),
                _buildDivider(),
                Expanded(
                  child: _buildFilterOption(
                    context: context,
                    title: "Luxury".tr,
                    value: "luxury",
                    controller: controller,
                  ),
                ),
                _buildDivider(),
                Expanded(
                  child: _buildFilterOption(
                    context: context,
                    title: "Economic".tr,
                    value: "economic",
                    controller: controller,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 24.h,
      width: 1.w,
      color: AppColor.backgroundicons2,
    );
  }

  Widget _buildFilterOption({
    required BuildContext context,
    required String title,
    required String value,
    required HomeControllerImp controller,
  }) {
    bool isSelected = controller.currentClassification.value == value;

    return Obx(() => GestureDetector(
      onTap: () => controller.filterByClassification(value),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: controller.currentClassification.value == value
              ? AppColor.selectedColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6.r),
        ),
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 4.h),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: controller.currentClassification.value == value
                ? FontWeight.bold
                : FontWeight.normal,
            fontSize: 14.sp,
          ),
        ),
      ),
    ));
  }
}