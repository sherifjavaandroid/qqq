import 'dart:ffi' as ffi;

import 'package:easycut/controller/main/booking_controller.dart';
import 'package:easycut/core/class/handling_data_view.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/linkapi.dart';
import 'package:easycut/view/widget/auth/custom_buttom_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

//Get.offNamed(AppRoute.home);
class BookSalonView extends StatelessWidget {
  const BookSalonView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BookingControllerImp());
    double appBarHeight = kToolbarHeight; // Default AppBar height (56.0)
    double appBarWidth = MediaQuery.of(context).size.width; // Full screen width
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(appBarWidth, appBarHeight - 2),
        child: AppBar(
          // bottom: ,
          centerTitle: true,
          title: SmallText(
            text: 'Book Now'.tr,
            size: 24,
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
                  color: const Color(0xFF292D32), // Border color #292D32
                  width: 1.5.w, // Updated border width to 1.5px
                ),
                borderRadius: BorderRadius.circular(10.r), // Rounded corners
                shape: BoxShape.rectangle, // Ensures it's a rectangle
              ),
              child: SizedBox(
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
        ),
      ),
      body: GetBuilder<BookingControllerImp>(
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: Padding(
              padding: EdgeInsets.only(right: 37.w, left: 38.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 110.h,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.services.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                            top: 20.h,
                            bottom: 1.h,
                          ),
                          child: Container(
                            width: 285.w,
                            height: 150.h,
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 1), // Added spacing between items
                            decoration: BoxDecoration(
                              color: AppColor.selectedColor,
                              border: Border.all(
                                  color: AppColor.backgroundicons2, width: 1.w),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                controller
                                    .chooseServices(controller.services[index]);
                              },
                              child: Row(
                                children: [
                                  // Image Section
                                  Container(
                                    width: 85.w,
                                    height: 85.h,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(190.r),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: Image.network(
                                        "${AppLink.imageServices}${controller.services[index].image}",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          22.w), // Space between image and text

                                  // Service Name, Price, and Time
                                  SizedBox(
                                    width: 154.w,
                                    height: 78.h,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        BigText(
                                          maxLines: 1,
                                          text:
                                              controller.services[index].name!,
                                          size: 18.sp,
                                          color: AppColor.backgroundicons,
                                        ),
                                        SmallText(
                                          text:
                                              "${'Time'.tr}: ${controller.services[index].time ?? 'N/A'} ${'min'.tr}",
                                          color: AppColor.backgroundicons,
                                          size: Dimensions.font16.sp,
                                        ),
                                        SmallText(
                                          text:
                                              "${controller.services[index].price!} \$",
                                          color: AppColor.backgroundicons,
                                          size: Dimensions.font16.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  BigText(
                    text: "Name".tr,
                    size: 18.sp,
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    height: 50.h,
                    width: 354.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColor.backgroundicons2,
                          width: 1.w,
                        ),
                        color: AppColor.backgroundButton),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SmallText(
                          fontFamily: 'Cairo',
                          size: 16.sp,
                          text: controller.userName,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.h),
                  BigText(
                    text: "Salon Name".tr,
                    size: 18.sp,
                  ),
                  SizedBox(height: 5.h),
                  Container(
                      height: 50.h,
                      width: 354.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          border: Border.all(
                            color: AppColor.backgroundicons2,
                            width: 1,
                          ),
                          color: AppColor.backgroundButton),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SmallText(
                            fontFamily: 'Cairo',
                            size: 16.sp,
                            text: controller.salon.name!,
                          ),
                        ),
                      )),
                  SizedBox(height: 5.h),
                  BigText(
                    text: "Choose Chair".tr,
                    size: 18.sp,
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 50.h, // تأكد من أن الارتفاع متناسق مع التصميم
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: int.parse(controller.salon.chairs.toString()),
                      itemBuilder: (context, index) {
                        bool isSelected = controller.chair == index;
                        return GestureDetector(
                          onTap: () {
                            controller.chooseChair(index);
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            height: 50.h,
                            width: 82.w,
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.width10.w),
                            margin: EdgeInsets.symmetric(horizontal: 5.w),
                            // ضبط التباعد بشكل متناسق
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  12.r), // زيادة التقويس قليلاً
                              border: Border.all(
                                color: isSelected
                                    ? AppColor.selectedColor
                                    : AppColor.backgroundicons2,
                                width: isSelected
                                    ? 2.w
                                    : 1.w, // جعل الحد أكثر وضوحًا عند التحديد
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: AppColor.selectedColor
                                            .withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: Offset(0, 4),
                                      )
                                    ]
                                  : [],
                              color: isSelected
                                  ? AppColor.selectedColor
                                  : AppColor.backgroundButton,
                            ),
                            child: Center(
                              child: SmallText(
                                text: "${'Chair'.tr} ${index + 1}",
                                fontWeight: FontWeight.bold,
                                size: 16.sp, // تكبير الخط قليلاً
                                color: isSelected
                                    ? Colors.black87
                                    : Colors.black87, // تغيير اللون عند التحديد
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: 5.h),
                  BigText(
                    text: "Choose Date".tr,
                    size: 18.sp,
                  ),
                  SizedBox(height: 5.h),
                  Column(
                    children: [
                      CustomButtonImage(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                            ),
                            firstDate: DateTime(
                              DateTime.now().year,
                              DateTime.now().month,
                              DateTime.now().day,
                            ),
                            lastDate: DateTime(DateTime.now().year + 3),
                          ).then((value) {
                            // 2023-08-16 00:00:00.000 -> 2023-08-16
                            var date = value.toString().substring(0, 10);
                            controller.chooseDate(date);
                          }).catchError((error) {});
                        },
                        color: AppColor.backgroundicons2,
                        text: controller.date,
                        suffiximage: 'assets/images/icon/calendar.png',
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),

                  BigText(
                    text: "Choose Time".tr,
                    size: 18.sp,
                  ),
                  SizedBox(height: 5.h),
                  Column(
                    children: [
                      CustomButtonImage(
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          showAvailableTimes(context);
                        },
                        color: AppColor.backgroundicons2,
                        text: controller.time,
                        suffiximage: 'assets/images/icon/clock.png',
                      ),
                    ],
                  ),

                  Spacer(),
                  // SizedBox(
                  //   height: Dimensions.height100,
                  //   child: Center(
                  //     child: TextButton.icon(
                  //         onPressed: () {
                  //           Get.offAllNamed(AppRoute.login);
                  //         },
                  //         icon: const Icon(Icons.login),
                  //         label: SmallText(
                  //           text:
                  //               'Please login first to choose among various barbers in your location'
                  //                   .tr,
                  //           size: Dimensions.font16,
                  //         )),
                  //   ),
                  // ),
                  // CustomButtonAuth(
                  //   onPressed: () {
                  //     controller.submitBooking();
                  //   },
                  //   text: "login".tr,
                  // ),
                  GestureDetector(
                    onTap: () {
                      controller.submitBooking();
                    },
                    child: Container(
                      height: 51.h,
                      width: 406.w,
                      decoration: BoxDecoration(
                        color: AppColor.selectedColor,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColor.backgroundicons2,
                          width: 1.w,
                        ),
                      ),
                      child: Center(
                        child: SmallText(
                          text: "Submit".tr,
                          color: const Color(0xff060807),
                          size: 20.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showAvailableTimes(BuildContext context) {
    try {
      final BookingControllerImp? controller = Get.find<BookingControllerImp>();

      if (controller == null) {
        Get.snackbar("Error".tr, "Controller not found.".tr,
            colorText: Colors.red);
        return;
      }

      List<String> availableTimes = controller.availableTimes?.toList() ?? [];

      if (availableTimes.isEmpty) {
        Get.snackbar("Error".tr, "No available times found.".tr,
            colorText: Colors.red);
        return;
      }

      showModalBottomSheet(
        context: context,
        isScrollControlled: true, // Better usability
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(16.r),
            height: 300.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Select Available Time".tr,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Divider(),
                Expanded(
                  child: ListView.builder(
                    itemCount: availableTimes.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(availableTimes[index],
                            style: TextStyle(fontSize: 16)),
                        trailing: Icon(Icons.access_time, color: Colors.blue),
                        onTap: () {
                          controller.chooseTime(availableTimes[index]);
                          Navigator.pop(
                              context); // Close BottomSheet after selection
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    } catch (e) {
      Get.snackbar("Error".tr, "Unexpected error: $e".tr,
          colorText: Colors.red);
    }
  }
}
