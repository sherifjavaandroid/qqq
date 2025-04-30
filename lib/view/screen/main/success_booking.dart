import 'package:easycut/controller/main/success_booking_controller.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/main.dart';
import 'package:easycut/view/widget/auth/custom_button_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SuccessBokking extends StatelessWidget {
  const SuccessBokking({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SuccessBookingControllerImp());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: SmallText(
          text: 'Booking Details'.tr,
          size: 24.sp,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 36.h,
            width: 36.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColor.backgroundicons, // Border color #292D32
                width: 1.5.w, // Updated border width to 1.5px
              ),
              borderRadius: BorderRadius.circular(10.r), // Rounded corners
              shape: BoxShape.rectangle, // Ensures it's a rectangle
            ),
            child: IconButton(
              icon: const ImageIcon(
                AssetImage('assets/images/icon/back_arrow.png'),
              ),
              onPressed: () {
                Get.offAllNamed(AppRoute.home);
              },
            ),
          ),
        ),
      ),
      body: GetBuilder<SuccessBookingControllerImp>(
        builder: (controller) {
          return Column(
            children: [
              SizedBox(height: Dimensions.height45.h),
              SizedBox(
                height: 118.h,
                width: 104.w,
                child: Image.asset('assets/images/icon/menu-board.png'),
              ),
              SizedBox(height: Dimensions.height20.h),
              Container(
                height: 250.h,
                width: 262.w,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: AppColor.unselectedservies,
                  border: Border.all(
                    color: AppColor.backgroundicons2,
                    width: 1.w,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Column(
                  children: [
                    _buildBookingDetailRow("Salon Name".tr, controller.salonName!),
                    SizedBox(height: 5.h),
                    _buildBookingDetailRow("Chair".tr, controller.chair!),
                    SizedBox(height: 5.h),
                    _buildBookingDetailRow("Day".tr, controller.day!),
                    SizedBox(height: 5.h),
                    _buildBookingDetailRow("Start Time".tr, controller.time!),
                    SizedBox(height: 5.h),
                    _buildBookingDetailRow("Total Time".tr, "${controller.endTime!} ${'min'.tr}"),
                    SizedBox(height: 5.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BigText(
                          color: AppColor.primaryColor,
                          text: "Total Price".tr,
                          size: 18.sp,
                        ),
                        SmallText(
                          text: "${controller.total!} \$",
                          color: AppColor.primaryColor,
                          size: 16.sp,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: CustomButtonAuth(
                  onPressed: () {
                    // Rebuild app after navigating back to home
                    Get.offAllNamed(AppRoute.home);
                  },
                  text: "Back to Home".tr,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBookingDetailRow(String label, String value) {
    return SizedBox(
      height: 34.h,
      width: 345.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BigText(
            text: label,
            size: 18.sp,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 110.w),
            child: SmallText(
              text: value,
              color: AppColor.backgroundicons,
              size: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}