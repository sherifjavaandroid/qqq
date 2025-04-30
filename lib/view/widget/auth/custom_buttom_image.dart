import 'package:easycut/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonImage extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final String? suffiximage;
  final Color? color;
  final EdgeInsets? padding;
  const CustomButtonImage({
    Key? key,
    required this.text,
    this.onPressed,
    this.suffiximage = 'assets/images/icon/gallery-add.png',
    this.color = Colors.black,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Use the same horizontal padding as your text field if desired
      padding: padding ?? EdgeInsets.only(right: 38.w, left: 38.w),
      child: Container(
        width: 364.w, // Set width
        height: 51.h, // Set height
        // Mimic the text field's decoration using BoxDecoration
        decoration: BoxDecoration(
          color: AppColor.backgroundButton,
          borderRadius: BorderRadius.circular(8.r),

          // Optionally, add a border similar to the OutlineInputBorder
          border: Border.all(
            color: AppColor
                .backgroundicons2, // or any color that matches your theme
          ),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          padding: EdgeInsets.symmetric(vertical: 6.h),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
            side: BorderSide(width: 1.w, color: AppColor.backgroundButton),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp),
                ),
              ),
              IconButton(
                  onPressed: onPressed,
                  icon: ImageIcon(
                    AssetImage(suffiximage!),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
