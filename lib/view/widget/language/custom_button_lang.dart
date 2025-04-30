import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButtonLang extends StatelessWidget {
  final String textButton;
  final void Function()? onPressed;
  const CustomButtonLang({
    super.key,
    required this.textButton,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, left: 104.w, right: 104.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColor.backgroundicons2,
            width: 1.w,
          ),
        ),
        width: 232.w,
        height: 51.h,
        child: MaterialButton(
            onPressed: onPressed,
            color: AppColor.iconColor1,
            textColor: Colors.black,
            child: BigText(
              text: textButton,
              size: 16.sp,
            )),
      ),
    );
  }
}
