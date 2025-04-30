import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/constant/image_asset.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderAuth extends StatelessWidget {
  const HeaderAuth({
    super.key,
    required this.title,
    this.firstDesc,
    required this.secondDesc,
  });

  final String title;
  final String? firstDesc;
  final String secondDesc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280.h,
      width: 280.w,
      child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Center(
              child: Image.asset(AppImageAsset.logo),
            ),
          ),
          BigText(text: title, color: Colors.black, size: Dimensions.font32.sp),
          //   SizedBox(height: Dimensions.height10),
          // SmallText(
          //   text: firstDesc ?? '',
          //   size: Dimensions.font12,
          //   fontWeight: FontWeight.w600,
          //   textAlign: TextAlign.center,
          //   color: Colors.black54,
          // ),
          SmallText(
            text: secondDesc,
            size: Dimensions.font16,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
          SizedBox(height: Dimensions.height50),
        ],
      ),
    );
  }
}
