import 'package:easycut/app.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/data/model/comment_model.dart';
import 'package:easycut/data/model/home_model.dart';
import 'package:easycut/data/model/products_model.dart';
import 'package:easycut/data/model/salon_model.dart';
import 'package:easycut/data/model/services_model.dart';
import 'package:easycut/view/widget/home/show_salon_card.dart';
import 'package:easycut/view/widget/main/about_salon.dart';
import 'package:easycut/view/widget/main/show_products_salon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/home/salon_controller.dart';

class StackSalonDetails extends StatelessWidget {
  final SalonModel salon;
  final List<ServiceModel> services;
  final List<ProductModel> products;
  final List<CommentModel> comments;

  const StackSalonDetails({
    super.key,
    required this.salon,
    required this.services,
    required this.products,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    final tabControllerX = Get.put(TabSalonController());

    return Positioned(
      top: 207.h,
      left: 0,
      right: 0,
      bottom: 0,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              Container(
                height: constraints.maxHeight,
                width: double.infinity,
                // padding: EdgeInsets.only(
                //   right: Dimensions.width20.w,
                //   left: Dimensions.width20.w,
                //   top: Dimensions.height20.h,
                // ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20.r),
                    topLeft: Radius.circular(Dimensions.radius20.r),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: Dimensions.width20.w,
                        left: Dimensions.width20.w,
                        top: Dimensions.height20.h,
                      ),
                      child: ShowSalonCard(
                        text: "${salon.name ?? ''}",
                        phone: "${salon.phone}",
                        gender: "${salon.categoryId}",
                        rate: "${salon.rate}",
                      ),
                    ),
                    SizedBox(height: Dimensions.height10.h),

                    // ✅ Wrap only the part that changes in Obx
                    Container(
                      width: double.infinity,
                      height: 41.h,
                      decoration: BoxDecoration(
                        border: Border.symmetric(
                          horizontal: BorderSide(
                            color: AppColor.backgroundicons2,
                            width: 1.w,
                          ),
                        ),
                      ),
                      child: Obx(() => Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      tabControllerX.tabController.animateTo(0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 41,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color:
                                          tabControllerX.selectedIndex.value ==
                                                  0
                                              ? AppColor.selectedColor
                                              : Colors.white,
                                    ),
                                    child: Text(
                                      "Services".tr,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      tabControllerX.tabController.animateTo(1),
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 41.h,
                                    decoration: BoxDecoration(
                                      color:
                                          tabControllerX.selectedIndex.value ==
                                                  1
                                              ? AppColor.selectedColor
                                              : Colors.white,
                                    ),
                                    child: Text(
                                      "Products".tr,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),

                    // ✅ Use GetBuilder instead of Obx for TabController
                    GetBuilder<TabSalonController>(
                      builder: (controller) {
                        return Expanded(
                          child: TabBarView(
                            controller: controller.tabController,
                            children: [
                              AboutSalon(services: services),
                              ShowProductsSalon(products: products),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
