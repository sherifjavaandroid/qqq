import 'package:easycut/controller/home/home_controller.dart';
import 'package:easycut/controller/main/salon_detail_controller.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/view/widget/home/icon_and_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ShowSalonCard extends StatelessWidget {
  final String text;
  final String phone;
  final String gender;
  final String rate;

  const ShowSalonCard({
    super.key,
    required this.text,
    required this.phone,
    required this.gender,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure both controllers are available
    final salonController = Get.find<SalonDetailControllerImp>();
    final homeController = Get.find<HomeControllerImp>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ConstrainedBox(
              constraints:
                  BoxConstraints(maxWidth: 190.w), // Limit width to 150 pixels(
              child: BigText(
                maxLines: 1,
                text: text,
                size: 24.sp,
              ),
            ),
            homeController.isLoggedIn
                ? Container()
                : IconAndTextWidget(
                    icon: 'assets/images/icon/call-calling2.png',
                    text: phone,
                    iconColor: AppColor.primaryColor,
                  ),
          ],
        ),
        SizedBox(height: Dimensions.height10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RatingBar(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemSize: 20, // ✅ Match star size
                  ratingWidget: RatingWidget(
                    full: SizedBox(
                      height: 18.h,
                      width: 18.w,
                      child: const ImageIcon(
                          color: AppColor.selectedColor,
                          AssetImage(
                            'assets/images/icon/heartstar.png',
                          )),
                    ),
                    half: SizedBox(
                      height: 18.h,
                      width: 18.w,
                      // child: const Icon(Icons.star_half_rounded,
                      //     size: 21, color: Colors.amber),
                    ),
                    empty: SizedBox(
                      height: 18.h,
                      width: 18.w,
                      child: const ImageIcon(AssetImage(
                        'assets/images/icon/star.png',
                      )),
                    ),
                  ),
                  onRatingUpdate: (newRating) {
                    if (salonController.salonId != null) {
                      salonController.feedbackSalonRating(
                          salonController.salonId!, newRating);
                      salonController.update();
                    } else {
                      Get.snackbar(
                        'Error',
                        'Salon ID is missing!',
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Colors.red,
                      );
                    }
                  },
                ),
                SizedBox(width: 6.w),
                GetBuilder<SalonDetailControllerImp>(
                  builder: (controller) {
                    return Text(
                      controller.currentRating.toInt().toString(),
                      style: TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    );
                  },
                ),
              ],
            ),
            IconAndTextWidget(
              icon: gender == "1"
                  ? 'assets/images/icon/man.png'
                  : 'assets/images/icon/woman.png',
              text: gender == "1" ? "Men" : "women",
              fontsize: 14.sp,
              iconColor: AppColor.grey,
            ),
          ],
        ),
      ],
    );
  }
}
