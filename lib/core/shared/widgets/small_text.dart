import 'package:easycut/app.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SmallText extends StatelessWidget {
  const SmallText({
    Key? key,
    this.color = AppColor.backgroundicons,
    required this.text,
    this.textAlign = TextAlign.center,
    this.overFlow = TextOverflow.ellipsis,
    this.fontFamily = 'Cairo',
    this.fontWeight = FontWeight.w600,
    this.size = 0,
    this.height = 1.2,
    this.maxline = 1,
  }) : super(key: key);

  final String text;
  final Color? color;
  final double size;
  final double height;
  final TextOverflow overFlow;
  final TextAlign textAlign;
  final String? fontFamily;
  final FontWeight fontWeight;
  final int maxline;
  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: maxline,
      text,
      textAlign: textAlign,
      overflow: overFlow,
      style: TextStyle(
        fontFamily: fontFamily,
        fontWeight: fontWeight,
        color: color,
        fontSize: size == 0 ? Dimensions.font16.sp : size,
        height: height,
      ),
    );
  }
}
