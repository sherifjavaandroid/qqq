import 'package:easycut/core/constant/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconAndTextWidget extends StatelessWidget {
  final String icon;
  final String? text;
  final Color iconColor;
  final double fontsize;
  const IconAndTextWidget({
    super.key,
    required this.icon,
    this.text,
    required this.iconColor,
    this.fontsize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          icon, // Ensure this is a valid image path string
          height: 18.h, // Adjust size as needed
          width: 18.w,
        ),
        SizedBox(width: Dimensions.width5.w),
        Text(
          maxLines: 1,
          text!,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: fontsize.sp,
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
