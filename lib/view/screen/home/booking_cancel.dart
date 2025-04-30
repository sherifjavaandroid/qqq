
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/home/booking_cancel_controller.dart';

class BookingCancellationScreen extends StatelessWidget {
  const BookingCancellationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get booking ID from arguments
    final Map<String, dynamic> args = Get.arguments;
    final int bookingId = args['bookingId'];
    final String bookingDay = args['day'];
    final String bookingTime = args['time'];
    final String salonName = args['salonName'];

    // Initialize controller
    final controller = Get.put(BookingCancellationController(bookingId: bookingId, bookingDay: bookingDay, bookingTime: bookingTime));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BigText(text: "Booking Options".tr),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 36.h,
            width: 36.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColor.backgroundicons,
                width: 1.5.w,
              ),
              borderRadius: BorderRadius.circular(10.r),
              shape: BoxShape.rectangle,
            ),
            child: IconButton(
              icon: const ImageIcon(
                AssetImage('assets/images/icon/back_arrow.png'),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
      ),
      body: GetBuilder<BookingCancellationController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Booking details card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: AppColor.backgroundButton,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColor.backgroundicons2, width: 1.w),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.store, color: AppColor.primaryColor),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: BigText(
                                text: salonName,
                                color: AppColor.primaryColor,
                                size: 18.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, color: AppColor.backgroundicons),
                            SizedBox(width: 10.w),
                            SmallText(
                              text: bookingDay,
                              color: AppColor.backgroundicons,
                              size: 16.sp,
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            const Icon(Icons.access_time, color: AppColor.backgroundicons),
                            SizedBox(width: 10.w),
                            SmallText(
                              text: bookingTime,
                              color: AppColor.backgroundicons,
                              size: 16.sp,
                            ),
                          ],
                        ),

                        SizedBox(height: 15.h),

                        // Countdown to booking time or cancellation deadline
                        if (controller.canCancel)
                          Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              color: AppColor.selectedColor.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Column(
                              children: [
                                SmallText(
                                  text: "You can cancel this booking until:".tr,
                                  color: Colors.black87,
                                  size: 14.sp,
                                ),
                                SizedBox(height: 5.h),
                                BigText(
                                  text: controller.cancellationDeadline,
                                  color: AppColor.primaryColor,
                                  size: 16.sp,
                                ),
                                SizedBox(height: 5.h),
                                Obx(() => SmallText(
                                  text: controller.remainingTimeText.value,
                                  color: controller.isCloseToDeadline.value ? Colors.red : Colors.black87,
                                  size: 14.sp,
                                  fontWeight: FontWeight.bold,
                                )),
                              ],
                            ),
                          )
                        else
                          Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              color: Colors.red.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(Icons.info_outline, color: Colors.red),
                                    SizedBox(width: 10.w),
                                    Expanded(
                                      child: SmallText(
                                        text: "This booking can no longer be cancelled as it's less than 6 hours before the appointment.".tr,
                                        color: Colors.red,
                                        size: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Options Section
                  BigText(
                    text: "Booking Options".tr,
                    size: 20.sp,
                  ),
                  SizedBox(height: 15.h),

                  // Cancellation Button
                  InkWell(
                    onTap: controller.canCancel ? () => _showCancellationDialog(context, controller) : null,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: controller.canCancel ? Colors.white : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: controller.canCancel ? Colors.red : Colors.grey,
                          width: 1.w,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.cancel_outlined,
                            color: controller.canCancel ? Colors.red : Colors.grey,
                            size: 24.sp,
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                  text: "Cancel Booking".tr,
                                  color: controller.canCancel ? Colors.red : Colors.grey,
                                  size: 18.sp,
                                ),
                                SizedBox(height: 5.h),
                                SmallText(
                                  text: controller.canCancel
                                      ? "Cancel this booking and get a refund".tr
                                      : "Cancellation is no longer available for this booking".tr,
                                  color: controller.canCancel ? Colors.black87 : Colors.grey,
                                  size: 14.sp,
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: controller.canCancel ? Colors.red : Colors.grey,
                            size: 18.sp,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 15.h),

                  // Reschedule Button
                  InkWell(
                    onTap: controller.canReschedule ? () => _showRescheduleDialog(context, controller) : null,
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: controller.canReschedule ? Colors.white : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: controller.canReschedule ? AppColor.primaryColor : Colors.grey,
                          width: 1.w,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.event_available,
                            color: controller.canReschedule ? AppColor.primaryColor : Colors.grey,
                            size: 24.sp,
                          ),
                          SizedBox(width: 15.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                  text: "Reschedule Booking".tr,
                                  color: controller.canReschedule ? AppColor.primaryColor : Colors.grey,
                                  size: 18.sp,
                                ),
                                SizedBox(height: 5.h),
                                SmallText(
                                  text: controller.canReschedule
                                      ? "Change the date and time of your booking".tr
                                      : "Rescheduling is no longer available for this booking".tr,
                                  color: controller.canReschedule ? Colors.black87 : Colors.grey,
                                  size: 14.sp,
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: controller.canReschedule ? AppColor.primaryColor : Colors.grey,
                            size: 18.sp,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Cancellation Policy
                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: "Cancellation Policy".tr,
                          size: 18.sp,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.error_outline, size: 16, color: Colors.grey),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: SmallText(
                                text: "You can cancel your booking up to 6 hours before the appointment time.".tr,
                                color: Colors.black87,
                                size: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.error_outline, size: 16, color: Colors.grey),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: SmallText(
                                text: "For cancellations made less than 6 hours before the appointment, no refund will be issued.".tr,
                                color: Colors.black87,
                                size: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.error_outline, size: 16, color: Colors.grey),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: SmallText(
                                text: "Rescheduling is subject to salon availability.".tr,
                                color: Colors.black87,
                                size: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showCancellationDialog(BuildContext context, BookingCancellationController controller) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Colors.red,
                size: 50.sp,
              ),
              SizedBox(height: 20.h),
              BigText(
                text: "Cancel Booking?".tr,
                size: 18.sp,
              ),
              SizedBox(height: 15.h),
              SmallText(
                text: "Are you sure you want to cancel this booking? This action cannot be undone.".tr,
                textAlign: TextAlign.center,
                size: 14.sp,
              ),
              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      "No, Keep It".tr,
                      style: TextStyle(
                        color: AppColor.primaryColor,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back(); // Close dialog
                      controller.cancelBooking();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "Yes, Cancel".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showRescheduleDialog(BuildContext context, BookingCancellationController controller) {
    // Navigate to reschedule screen instead of showing dialog
    Get.toNamed(AppRoute.rescheduleBooking, arguments: {
      'bookingId': controller.bookingId,
      'salonId': controller.salonId,
    });
  }
}