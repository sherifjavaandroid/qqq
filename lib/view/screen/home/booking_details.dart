import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/data/model/booking_model.dart';
import 'package:easycut/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/home/booking_detail_controller.dart';

class BookingDetailPage extends StatelessWidget {
  final BookingModel booking;

  const BookingDetailPage({
    Key? key,
    required this.booking,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize controller
    final controller = Get.put(BookingDetailController(booking: booking));

    // Calculate booking status from approve value
    String statusText = "Pending";
    Color statusColor = Colors.orange;

    if (booking.approve == "1") {
      statusText = "Confirmed";
      statusColor = Colors.green;
    } else if (booking.approve == "2") {
      statusText = "Cancelled";
      statusColor = Colors.red;
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BigText(text: "Booking Details".tr),
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
      body: GetBuilder<BookingDetailController>(
        builder: (controller) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Booking Status Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: statusColor, width: 1.w),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.r),
                          decoration: BoxDecoration(
                            color: statusColor.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            booking.approve == "1"
                                ? Icons.check_circle
                                : booking.approve == "2"
                                ? Icons.cancel
                                : Icons.access_time,
                            color: statusColor,
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 15.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BigText(
                              text: statusText.tr,
                              color: statusColor,
                              size: 18.sp,
                            ),
                            SizedBox(height: 5.h),
                            SmallText(
                              text: booking.approve == "1"
                                  ? "Your booking has been confirmed".tr
                                  : booking.approve == "2"
                                  ? "This booking has been cancelled".tr
                                  : "Waiting for salon confirmation".tr,
                              size: 14.sp,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Salon Info
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColor.backgroundicons2, width: 1.w),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Salon Image
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.r),
                            topRight: Radius.circular(8.r),
                          ),
                          child: booking.image != null && booking.image!.isNotEmpty
                              ? Image.network(
                            "${AppLink.imageSalons}${booking.image}",
                            height: 200.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 200.h,
                                width: double.infinity,
                                color: Colors.grey.shade200,
                                child: Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 50.sp,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
                          )
                              : Container(
                            height: 200.h,
                            width: double.infinity,
                            color: Colors.grey.shade200,
                            child: Center(
                              child: Icon(
                                Icons.store,
                                size: 50.sp,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),

                        // Salon Details
                        Padding(
                          padding: EdgeInsets.all(16.r),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BigText(
                                text: booking.salonname ?? "Unknown Salon".tr,
                                size: 20.sp,
                              ),
                              SizedBox(height: 10.h),
                              _buildInfoRow(
                                icon: Icons.email,
                                label: "Email".tr,
                                value: booking.email ?? "N/A",
                              ),
                              _buildInfoRow(
                                icon: Icons.phone,
                                label: "Phone".tr,
                                value: booking.phone ?? "N/A",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Booking Details
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.r),
                      border: Border.all(color: AppColor.backgroundicons2, width: 1.w),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BigText(
                          text: "Booking Information".tr,
                          size: 18.sp,
                        ),
                        SizedBox(height: 15.h),
                        _buildInfoRow(
                          icon: Icons.calendar_today,
                          label: "Date".tr,
                          value: booking.day ?? "N/A",
                        ),
                        _buildInfoRow(
                          icon: Icons.access_time,
                          label: "Time".tr,
                          value: booking.time ?? "N/A",
                        ),
                        _buildInfoRow(
                          icon: Icons.chair,
                          label: "Chair".tr,
                          value: booking.chair ?? "N/A",
                        ),
                        _buildInfoRow(
                          icon: Icons.attach_money,
                          label: "Total".tr,
                          value: "${booking.total ?? 'N/A'} \$",
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // Cancel/Reschedule Button - only show for active non-past bookings
                  if (controller.canModifyBooking)
                    GestureDetector(
                      onTap: () {
                        // Make sure the bookingId is converted to int correctly
                        int bookingId = int.tryParse(booking.id.toString()) ?? 0;

                        if (bookingId > 0) {
                          Get.toNamed(AppRoute.bookingCancellation, arguments: {
                            'bookingId': bookingId,
                            'day': booking.day ?? '',
                            'time': booking.time ?? '',
                            'salonName': booking.salonname ?? '',
                          });
                        } else {
                          Get.snackbar(
                            'Error'.tr,
                            'Invalid booking ID'.tr,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.r),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(color: Colors.red, width: 1.w),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.event_busy,
                              color: Colors.red,
                              size: 24.sp,
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              "Cancel or Reschedule".tr,
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Rate Salon Button - only show for completed bookings that aren't rated yet
                  if (controller.canRateBooking)
                    Padding(
                      padding: EdgeInsets.only(top: controller.canModifyBooking ? 15.h : 0),
                      child: GestureDetector(
                        onTap: () => controller.showRatingScreen(),
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(16.r),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(color: AppColor.primaryColor, width: 1.w),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: AppColor.primaryColor,
                                size: 24.sp,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "Rate Your Experience".tr,
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20.sp, color: AppColor.primaryColor),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SmallText(
                  text: label,
                  size: 14.sp,
                  color: Colors.grey,
                ),
                SizedBox(height: 3.h),
                SmallText(
                  text: value,
                  size: 16.sp,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}