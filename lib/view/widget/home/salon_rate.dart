import 'package:easycut/controller/home/salon_rates_controller.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SalonRatingWidget extends StatelessWidget {
  final int salonId;

  SalonRatingWidget({Key? key, required this.salonId}) : super(key: key);
  final SalonRatesController controller = Get.find<SalonRatesController>();
  @override
  Widget build(BuildContext context) {
    //this line make get all salon rates in one time
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchRating(salonId);
    });

    return GetBuilder<SalonRatesController>(
      builder: (controller) {
        bool isLoading = controller.loadingSalons[salonId] ?? true;
        double averageRate = controller.salonRatings[salonId] ?? 0.0;

        return Container(
          decoration: BoxDecoration(
            color: AppColor.selectedColor.withOpacity(.6),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: isLoading
              ? SizedBox(
                  height: 12.h,
                  width: 12.w,
                  child: const Center(
                    child: CircularProgressIndicator(
                        color: AppColor.selectedColor),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20.sp),
                    SizedBox(width: 4.w),
                    Text(
                      averageRate.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 4.sp),
                  ],
                ),
        );
      },
    );
  }
}
