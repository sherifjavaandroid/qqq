import 'package:easycut/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonSearch extends StatelessWidget {
  final String hintText;
  final void Function()? onPressed;
  final String? prefixIcon;

  const CustomButtonSearch({
    Key? key,
    required this.hintText,
    this.onPressed,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Use the same horizontal padding as your text field if desired
      padding: EdgeInsets.only(right: 38.w, left: 38.w),
      child: Container(
        width: 364.w, // Set width
        height: 41.h, // Set height
        // Mimic the text field's decoration using BoxDecoration
        decoration: BoxDecoration(
          color: AppColor.backgroundButton,
          borderRadius: BorderRadius.circular(4.r),

          // Optionally, add a border similar to the OutlineInputBorder
          border: Border.all(
            color: AppColor
                .backgroundicons2, // or any color that matches your theme
          ),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          padding: EdgeInsets.symmetric(vertical: 6.h),
          // Remove the MaterialButton color since the Container already provides it
          // color: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
            side: BorderSide(width: 1.w, color: AppColor.backgroundButton),
          ),
          child: Row(
            children: [
              SizedBox(width: 10.w),
              Image.asset(
                prefixIcon!, // Ensure this is a valid image path string
                height: 22.h, // Adjust size as needed
                width: 22.w,
              ),
              Container(
                height: 20.h, // Line height
                width: 1.w, // Line width
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                color: AppColor.backgroundicons2, // Line color
              ),
              //SizedBox(width: 100.w),
              Text(
                hintText,
                style: TextStyle(
                    color: AppColor.backgroundicons2,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
