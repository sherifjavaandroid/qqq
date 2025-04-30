import 'package:easycut/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonAuth extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final IconData? suffixIcon;

  const CustomButtonAuth({
    super.key,
    required this.text,
    this.onPressed,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h, right: 38.w, left: 38.w),
      child: SizedBox(
        height: 51.h, // Set height
        width: 364.w, // Set width
        child: MaterialButton(
          onPressed: onPressed,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: BorderSide(
                width: 1.w, color: AppColor.iconColor1), // Border width 1px
          ),
          color: AppColor.iconColor1,
          textColor: Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
              ),
              if (suffixIcon != null)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    suffixIcon,
                    color: Colors.white, // Set the icon color to white
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
