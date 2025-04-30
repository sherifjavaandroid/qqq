
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/view/widget/auth/custom_button_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/home/reschadle_controller.dart';

class RescheduleBookingScreen extends StatelessWidget {
  const RescheduleBookingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get booking ID and salon ID from arguments
    final Map<String, dynamic> args = Get.arguments;
    final int bookingId = args['bookingId'];
    final int salonId = args['salonId'];

    // Initialize controller
    final controller = Get.put(RescheduleBookingController(bookingId: bookingId, salonId: salonId));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BigText(text: "Reschedule Booking".tr),
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
      body: GetBuilder<RescheduleBookingController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Instructions
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: AppColor.backgroundButton,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColor.backgroundicons2, width: 1.w),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        text: "Choose New Date & Time".tr,
                        size: 18.sp,
                      ),
                      SizedBox(height: 10.h),
                      SmallText(
                        text: "Select a new date and time for your appointment. Available time slots will be shown based on salon availability.".tr,
                        size: 14.sp,
                      ),
                      SizedBox(height: 5.h),
                      SmallText(
                        text: "Note: Rescheduling is subject to salon availability.".tr,
                        size: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),

                // Date Selection
                BigText(
                  text: "Choose Date".tr,
                  size: 18.sp,
                ),
                SizedBox(height: 10.h),

                // Date button
                GestureDetector(
                  onTap: () => _selectDate(context, controller),
                  child: Container(
                    width: double.infinity,
                    height: 50.h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColor.backgroundicons2, width: 1.w),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SmallText(
                          text: controller.selectedDate ?? "Select Date".tr,
                          size: 16.sp,
                        ),
                        const Icon(Icons.calendar_today, color: AppColor.primaryColor),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Time Selection
                BigText(
                  text: "Choose Time".tr,
                  size: 18.sp,
                ),
                SizedBox(height: 10.h),

                // Time slots
                controller.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : controller.availableTimeSlots.isEmpty
                    ? Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Center(
                    child: SmallText(
                      text: controller.selectedDate == null
                          ? "Please select a date first".tr
                          : "No available time slots for this date".tr,
                      size: 16.sp,
                    ),
                  ),
                )
                    : SizedBox(
                  height: 230.h,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.5,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                    ),
                    itemCount: controller.availableTimeSlots.length,
                    itemBuilder: (context, index) {
                      final timeSlot = controller.availableTimeSlots[index];
                      final isSelected = controller.selectedTimeSlot == timeSlot;

                      return GestureDetector(
                        onTap: () {
                          controller.selectTimeSlot(timeSlot);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isSelected ? AppColor.selectedColor : Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              color: isSelected ? AppColor.primaryColor : AppColor.backgroundicons2,
                              width: isSelected ? 2.w : 1.w,
                            ),
                          ),
                          child: Center(
                            child: SmallText(
                              text: timeSlot,
                              size: 14.sp,
                              color: isSelected ? AppColor.primaryColor : Colors.black87,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const Spacer(),

                // Reschedule Button
                CustomButtonAuth(
                  text: "Reschedule Booking".tr,
                  onPressed: controller.canReschedule
                      ? () => _showConfirmationDialog(context, controller)
                      : null,
                ),

                SizedBox(height: 20.h),
              ],
            ),
          );
        },
      ),
    );
  }

  void _selectDate(BuildContext context, RescheduleBookingController controller) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now.add(const Duration(days: 1)),
      firstDate: now,
      lastDate: now.add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColor.primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.setSelectedDate(picked);
    }
  }

  void _showConfirmationDialog(BuildContext context, RescheduleBookingController controller) {
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
                Icons.event_available,
                color: AppColor.primaryColor,
                size: 50.sp,
              ),
              SizedBox(height: 20.h),
              BigText(
                text: "Confirm Reschedule?".tr,
                size: 18.sp,
              ),
              SizedBox(height: 15.h),
              SmallText(
                text: "Are you sure you want to reschedule your booking to ${controller.selectedDate} at ${controller.selectedTimeSlot}?".tr,
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
                      "Cancel".tr,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back(); // Close dialog
                      controller.rescheduleBooking();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "Confirm".tr,
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
}