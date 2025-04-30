import 'package:easycut/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BigText extends StatelessWidget {
  const BigText({
    Key? key,
    required this.text,
    this.color = Colors.black,
    this.textAlign = TextAlign.center,
    this.overFlow = TextOverflow.ellipsis,
    this.fontFamily,
    this.fontWeight = FontWeight.w700,
    this.size = 0,
    this.maxLines = 3,
  }) : super(key: key);

  final String text;
  final Color? color;
  final double size;
  final TextOverflow overFlow;
  final TextAlign textAlign;
  final String? fontFamily;
  final FontWeight fontWeight;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overFlow,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: fontFamily,
        color: color,
        fontSize: size == 0 ? 24.sp : size,
        fontWeight: fontWeight,
      ),
    );
  }
}
