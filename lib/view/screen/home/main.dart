import 'package:carousel_slider/carousel_slider.dart';
import 'package:easycut/controller/home/home_controller.dart';
import 'package:easycut/core/class/handling_data_view.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/constant/image_asset.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/view/screen/home/salonsearchdelegate.dart';
import 'package:easycut/view/widget/auth/custom_buttom_search.dart';
import 'package:easycut/view/widget/exitdialog.dart';
import 'package:easycut/view/widget/home/guest_NewestSalonItem.dart';
import 'package:easycut/view/widget/home/header_main_view.dart';
import 'package:easycut/view/widget/home/location_indicator.dart';
import 'package:easycut/view/widget/home/newest_salon_item.dart';
import 'package:easycut/view/widget/home/newest_text.dart';
import 'package:easycut/view/widget/home/sliding_popular_salons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/constant/color.dart';
import '../../../features/search/controller/carousel_controller_x.dart';
import '../../widget/home/salon_classification_filter_widget.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});
  @override
  Widget build(BuildContext context) {
    final CarouselControllerX controllerX = Get.put(CarouselControllerX());

    final List<String> imageList = [
      'assets/images/salonbk/salon1.jpg',
      'assets/images/salonbk/salon2.jpg',
      'assets/images/salonbk/salon4.jpg',
    ];

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showExitConfirmationDialog(context);
        return shouldPop ?? false;
      },
      child: SingleChildScrollView(
        child: SafeArea(
          child: GetBuilder<HomeControllerImp>(
            builder: (controller) {
              return Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 38.w,
                      right: 38.w,
                    ),
                    child: HeaderMainView(
                      name: controller.name,
                      image: controller.image,
                    ),
                  ),
                  SizedBox(height: Dimensions.height10),

                  // Location indicator
                  const LocationIndicator(),
                  SizedBox(height: 10.h),

                  CustomButtonSearch(
                    onPressed: () {
                      Get.offNamed(AppRoute.searchSalon);
                    },
                    prefixIcon: AppImageAsset.search,
                    hintText: "Search".tr,
                  ),

                  // Add the salon classification filter widget
                  const SalonClassificationFilter(),

                  SizedBox(height: Dimensions.height10.h),
                  HandlingDataView(
                    statusRequest: controller.statusRequest,
                    widget: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.popSalons.isEmpty
                            ? Column(
                          children: [
                            SizedBox(
                              width: 364.w,
                              height: 225.h,
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  aspectRatio: 3.5,
                                  enlargeCenterPage: false,
                                  height: 225.h,
                                  autoPlay: true,
                                  autoPlayAnimationDuration:
                                  Durations.long1,
                                  onPageChanged: (index, reason) {
                                    controllerX.updateIndex(index);
                                  },
                                ),
                                items: imageList.map((imagePath) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return Container(
                                        margin: EdgeInsetsDirectional
                                            .symmetric(horizontal: 5.w),
                                        width: 364.w,
                                        height: 100.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black,
                                              width: 1.w),
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                          child: Image.asset(
                                            imagePath,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            ),
                            SizedBox(height: Dimensions.height10.h),
                            Obx(
                                  () => Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: List.generate(imageList.length,
                                        (index) {
                                      return Container(
                                        width: 8.w,
                                        height: 8.h,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 4.w),
                                        decoration: BoxDecoration(
                                          color: controllerX
                                              .currentIndex.value ==
                                              index
                                              ? AppColor.iconColor1
                                              : AppColor.backgroundicons2,
                                          shape: BoxShape.circle,
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        )
                            : SlidingPopularSalons(
                            popularSalon: controller.popSalons),

                        SizedBox(height: 10.h),

                        NewestText(
                          title: 'Near for you'.tr,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: 38.w,
                            right: 38.w,
                          ),
                          child: SmallText(
                            maxline: 1,
                            text:
                            "Don't waste your time and book at your preference"
                                .tr,
                            color: AppColor.titleColor,
                            size: 12.5.sp,
                          ),
                        ),

                        controller.isLoggedIn
                            ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.newSalons.length,
                            itemBuilder: (context, index) {
                              return GuestNewestsalonitem(
                                salon: controller.newSalons[index],
                              );
                            })
                            : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.newSalons.length,
                          itemBuilder: (context, index) {
                            return NewestSalonItem(
                              salon: controller.newSalons[index],
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
        ),
      ),
    );
  }
}