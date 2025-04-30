import 'package:easycut/controller/main/salon_detail_controller.dart';
import 'package:easycut/core/class/handling_data_view.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/helper/qrcode_helper.dart';
import 'package:easycut/linkapi.dart';
import 'package:easycut/view/widget/main/show_products_salon.dart';
import 'package:easycut/view/widget/main/stack_salon_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SalonDetails extends StatelessWidget {
  const SalonDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => SalonDetailControllerImp());
    Get.lazyPut(() => ShowProductsSalonController());

    return Scaffold(body: GetBuilder<SalonDetailControllerImp>(
      builder: (controller) {
        return GetBuilder<ShowProductsSalonController>(
          builder: (productController) {
            bool hasSelection = controller.selectedIndices.isNotEmpty ||
                productController.selectedIndices.isNotEmpty;

            return HandlingDataView(
              statusRequest: controller.statusRequest,
              widget: Column(
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        // Salon Image
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 29.h,
                          child: SizedBox(
                            width: double.infinity,
                            height: 328.h,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 14.h),
                              child: Image.network(
                                "${AppLink.imageSalons}${controller.salon.image}",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),

                        // Top navigation buttons including share and QR
                        Positioned(
                          left: 0,
                          right: 0,
                          top: Dimensions.height45.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Back button
                                Container(
                                  height: 36.h,
                                  width: 36.w,
                                  decoration: BoxDecoration(
                                    color: AppColor.unselectedservies,
                                    borderRadius: BorderRadius.circular(10.r),
                                    border: Border.all(
                                        width: 1.5,
                                        color: AppColor.backgroundicons
                                    ),
                                  ),
                                  child: IconButton(
                                    icon: const ImageIcon(
                                      color: AppColor.backgroundicons,
                                      AssetImage('assets/images/icon/back_arrow.png'),
                                    ),
                                    onPressed: () {
                                      Get.offNamed(AppRoute.home);
                                    },
                                  ),
                                ),

                                // Action buttons (QR, Share, Favorite)
                                Row(
                                  children: [
                                    // QR Code button
                                    Container(
                                      height: 36.h,
                                      width: 36.w,
                                      decoration: BoxDecoration(
                                        color: AppColor.unselectedservies,
                                        borderRadius: BorderRadius.circular(10.r),
                                        border: Border.all(
                                            width: 1.5,
                                            color: AppColor.backgroundicons
                                        ),
                                      ),
                                      child: IconButton(
                                        iconSize: 18.sp,
                                        icon: const Icon(
                                          Icons.qr_code,
                                          color: AppColor.backgroundicons,
                                        ),
                                        onPressed: () {
                                          QRCodeHelper.showQRCodeDialog(
                                            context,
                                            controller.salon.id ?? 0,
                                            controller.salon.name ?? "Salon",
                                          );
                                        },
                                      ),
                                    ),

                                    // Space between buttons
                                    SizedBox(width: 12.w),

                                    // Share button
                                    Container(
                                      height: 36.h,
                                      width: 36.w,
                                      decoration: BoxDecoration(
                                        color: AppColor.unselectedservies,
                                        borderRadius: BorderRadius.circular(10.r),
                                        border: Border.all(
                                            width: 1.5,
                                            color: AppColor.backgroundicons
                                        ),
                                      ),
                                      child: IconButton(
                                        iconSize: 18.sp,
                                        icon: const Icon(
                                          Icons.share,
                                          color: AppColor.backgroundicons,
                                        ),
                                        onPressed: () {
                                          QRCodeHelper.shareSalon(
                                            context,
                                            controller.salon.id ?? 0,
                                            controller.salon.name ?? "Salon",
                                          );
                                        },
                                      ),
                                    ),

                                    // Space between buttons
                                    SizedBox(width: 12.w),

                                    // Favorite button (if logged in)
                                    if (controller.isLoggedIn)
                                      GestureDetector(
                                        onTap: () {
                                          controller.changeFavoriteState();
                                        },
                                        child: Container(
                                          width: 33.w,
                                          height: 33.h,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black26,
                                                blurRadius: 4.0,
                                                spreadRadius: 1,
                                              ),
                                            ],
                                          ),
                                          child: controller.isFavorite!
                                              ? Image.asset(
                                            'assets/images/icon/Vector.png',
                                            height: 22.h,
                                            width: 22.w,
                                          )
                                              : Image.asset(
                                            'assets/images/icon/heart.png',
                                            height: 22.h,
                                            width: 22.w,
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        StackSalonDetails(
                          salon: controller.salon,
                          services: controller.services,
                          products: controller.products,
                          comments: controller.comments,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 406.w,
                    height: 51.h,
                    margin:
                    const EdgeInsets.only(left: 17, bottom: 10, right: 17),
                    decoration: BoxDecoration(
                      color: hasSelection
                          ? AppColor.selectedColor
                          : const Color(0xffB6B8B9),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: MaterialButton(
                      onPressed: () {
                        if (controller.isLoggedIn) {
                          Get.offNamed(AppRoute.bookSalonView, arguments: {
                            "services": controller.selectedServices,
                            "salon": controller.salon,
                          });
                        } else {
                          _showLoginBottomSheet(context);
                        }
                      },
                      child: SmallText(
                        size: 20.sp,
                        text: "Book Now".tr,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ));
  }
}

void _showLoginBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20.0.r),
      ),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.all(20.0.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Login Required".tr,
              style: TextStyle(
                fontSize: 18.0.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0.h),
            Text(
              "You need to log in to continue. Do you want to log in?".tr,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0.sp,
              ),
            ),
            SizedBox(height: 20.0.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoute.login);
                  },
                  child: Text("Log In".tr),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Cancel".tr),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}