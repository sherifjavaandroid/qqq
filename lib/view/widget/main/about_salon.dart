import 'package:easycut/controller/main/salon_detail_controller.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AboutSalon extends StatelessWidget {
  final List<dynamic> services;

  const AboutSalon({super.key, required this.services});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SalonDetailControllerImp>(
      init: SalonDetailControllerImp(),
      builder: (controller) {
        return LayoutBuilder(
          builder: (context, constr) {
            return Padding(
              padding: EdgeInsets.only(
                right: Dimensions.width20.w,
                left: Dimensions.width20.w,
                top: 5.h,
              ),
              child: SizedBox(
                height: 178.h,
                width: 221.w,
                child: GridView.builder(
                  padding: EdgeInsets.symmetric(
                    vertical: 0.h,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 2,
                    childAspectRatio: 3 / 4,
                  ),
                  itemCount: services.length,
                  itemBuilder: (context, index) {
                    bool isSelected = controller.isSelected(index);

                    return GestureDetector(
                      onTap: () => controller.toggleSelection(index),
                      child: Card(
                        color: isSelected
                            ? AppColor.selectedColor
                            : AppColor.unselectedservies,
                        child: Padding(
                          padding: EdgeInsets.all(10.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Expanded(
                                flex: 5,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4.r),
                                  child: SizedBox(
                                    height: 100.h,
                                    width: 158.w,
                                    child: Image.network(
                                      "${AppLink.imageServices}${services[index].image}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Column(
                                  children: [
                                    SmallText(
                                      fontWeight: FontWeight.w700,
                                      maxline: 2,
                                      text: services[index].name!,
                                      size: 18.sp,
                                    ),
                                    SmallText(
                                      text:
                                          "${'Time'.tr}: ${services[index].time} min",
                                      size: Dimensions.font16.sp,
                                    ),
                                    SmallText(
                                      fontFamily: 'Cairo',
                                      text:
                                          "${'Price:'.tr} ${services[index].price} \$",
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
            );
          },
        );
      },
    );
  }
}
