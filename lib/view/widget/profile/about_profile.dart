import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/view/screen/home/lauguage_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AboutProfile extends StatelessWidget {
  final String email;
  final String country;
  final String? gender;
  final String? city;
  final String? address;
  final String? phone;
  const AboutProfile({
    super.key,
    required this.email,
    required this.country,
    this.gender,
    this.city,
    this.address,
    this.phone,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: Dimensions.height20),
        BigText(text: "email".tr),
        SizedBox(height: Dimensions.height10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 50,
              width: 364,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.backgroundicons2, width: 1),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SmallText(
                    text: email,
                  ),
                ),
              ),
            ),
          ],
        ),
        BigText(text: "Country".tr),
        SizedBox(height: Dimensions.height10),
        Column(
          children: [
            Container(
              height: 50,
              width: 364,
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.backgroundicons2, width: 1),
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SmallText(
                    text: country,
                  ),
                ),
              ),
            ),
          ],
        ),

        BigText(text: "Language".tr),
        SizedBox(height: Dimensions.height10),
        Container(
          height: 50.h,
          width: 364.w,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            border: Border.all(color: AppColor.backgroundicons2, width: 1),
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const LanguageSwitcher(),
        ),
        SizedBox(height: Dimensions.height10),
        // BigText(text: "gender".tr),
        // SizedBox(height: Dimensions.height10),
        // SmallText(text: gender),
        // SizedBox(height: Dimensions.height10),
        // BigText(text: "phoneNumber".tr),
        // SizedBox(height: Dimensions.height10),
        // SmallText(text: phone),
        // SizedBox(height: Dimensions.height20),
        // BigText(text: "Address".tr),
        // SizedBox(height: Dimensions.height10),
        // SmallText(text: "$country  - $city  "),
      ],
    );
  }
}
