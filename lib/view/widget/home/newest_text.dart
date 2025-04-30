import 'package:easycut/core/constant/color.dart';

import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewestText extends StatelessWidget {
  final String title;
  const NewestText({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 38.w,
        right: 38.w,
      ),
      child: BigText(
        text: title,
        color: AppColor.primaryColor,
        size: 24.sp,
      ),
    );
  }
}
