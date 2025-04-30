
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/view/widget/auth/custom_button_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/home/book_rate_controller.dart';

class BookingRatingScreen extends StatelessWidget {
  const BookingRatingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get booking details from arguments
    final Map<String, dynamic> args = Get.arguments;
    final int bookingId = args['bookingId'];
    final String salonName = args['salonName'];
    final String bookingDate = args['bookingDate'];

    // Initialize controller
    final controller = Get.put(BookingRatingController(bookingId: bookingId));

    return WillPopScope(
      onWillPop: () async {
        // Prevent going back without submitting a rating
        _showExitConfirmationDialog(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: BigText(text: "Rate Your Experience".tr),
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false, // Prevent back button
        ),
        body: GetBuilder<BookingRatingController>(
          builder: (controller) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Salon details
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
                                text: bookingDate,
                                color: AppColor.backgroundicons,
                                size: 16.sp,
                              ),
                            ],
                          ),
                          SizedBox(height: 15.h),
                          SmallText(
                            text: "Your feedback helps improve our services and assists other users in finding quality salons. Thank you for taking time to rate your experience.".tr,
                            color: Colors.black87,
                            size: 14.sp,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // Service Quality Rating
                    _buildRatingSection(
                      context,
                      title: "Service Quality".tr,
                      description: "How was the quality of the haircut/styling?".tr,
                      icon: Icons.content_cut,
                      initialRating: controller.serviceQualityRating.toDouble(),
                      onRatingUpdate: (rating) {
                        controller.updateServiceQualityRating(rating.toInt());
                      },
                    ),

                    SizedBox(height: 20.h),

                    // Cleanliness Rating
                    _buildRatingSection(
                      context,
                      title: "Cleanliness".tr,
                      description: "How clean was the salon?".tr,
                      icon: Icons.cleaning_services,
                      initialRating: controller.cleanlinessRating.toDouble(),
                      onRatingUpdate: (rating) {
                        controller.updateCleanlinessRating(rating.toInt());
                      },
                    ),

                    SizedBox(height: 20.h),

                    // Customer Service Rating
                    _buildRatingSection(
                      context,
                      title: "Customer Service".tr,
                      description: "How was the staff's behavior and professionalism?".tr,
                      icon: Icons.people,
                      initialRating: controller.customerServiceRating.toDouble(),
                      onRatingUpdate: (rating) {
                        controller.updateCustomerServiceRating(rating.toInt());
                      },
                    ),

                    SizedBox(height: 30.h),

                    // Additional Comments
                    BigText(
                      text: "Additional Comments (Optional)".tr,
                      size: 18.sp,
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: AppColor.backgroundicons2, width: 1.w),
                      ),
                      child: TextField(
                        controller: controller.commentController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: "Share your experience or provide any additional feedback...".tr,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(16.r),
                        ),
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Submit Button
                    CustomButtonAuth(
                      text: "Submit Rating".tr,
                      onPressed: controller.canSubmit
                          ? () => controller.submitRating()
                          : null,
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildRatingSection(
      BuildContext context, {
        required String title,
        required String description,
        required IconData icon,
        required double initialRating,
        required Function(double) onRatingUpdate,
      }) {
    return Container(
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
          Row(
            children: [
              Icon(icon, color: AppColor.primaryColor),
              SizedBox(width: 10.w),
              BigText(
                text: title,
                size: 18.sp,
              ),
            ],
          ),
          SizedBox(height: 5.h),
          SmallText(
            text: description,
            size: 14.sp,
          ),
          SizedBox(height: 15.h),
          Center(
            child: RatingBar.builder(
              initialRating: initialRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemSize: 40.sp,
              unratedColor: Colors.grey.shade300,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: AppColor.selectedColor,
              ),
              onRatingUpdate: onRatingUpdate,
            ),
          ),
        ],
      ),
    );
  }

  void _showExitConfirmationDialog(BuildContext context) {
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
                color: Colors.orange,
                size: 50.sp,
              ),
              SizedBox(height: 20.h),
              BigText(
                text: "Exit Without Rating?".tr,
                size: 18.sp,
              ),
              SizedBox(height: 15.h),
              SmallText(
                text: "Your feedback is important to us and helps improve our services. Are you sure you want to exit without rating?".tr,
                textAlign: TextAlign.center,
                size: 14.sp,
              ),
              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.back(); // Close dialog
                      Get.offAllNamed(AppRoute.home); // Go to home screen
                    },
                    child: Text(
                      "Exit".tr,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Get.back(), // Close dialog and continue rating
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    child: Text(
                      "Continue Rating".tr,
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