import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:flutter/material.dart';

class RegisterInputField extends StatelessWidget {
  final String text;
  final Widget widget;
  const RegisterInputField({
    Key? key,
    required this.text,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.height100,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.width15,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF8FB1E9),
        borderRadius: BorderRadius.circular(
          Dimensions.radius15,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmallText(
            text: text,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          widget,
        ],
      ),
    );
  }
}
