import 'package:easycut/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFormAuth extends StatelessWidget {
  final String hintText;
  final TextInputType type;
  final String prefixIcon;
  final String? suffixIcon;
  final ImageIcon? icon;
  final TextEditingController myController;
  final bool obSecure;
  final void Function()? suffixPressed;
  final String? Function(String?)? valid;

  const CustomTextFormAuth({
    Key? key,
    required this.hintText,
    required this.type,
    required this.prefixIcon,
    this.suffixIcon,
    required this.myController,
    this.obSecure = false,
    this.suffixPressed,
    required this.valid,
    this.icon,
    InputDecoration? decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 38.w, left: 38.w),
      child: SizedBox(
        width: 364.w, // Set width
        height: 51.h, // Set height
        child: TextFormField(
          controller: myController,
          keyboardType: type,
          obscureText: obSecure,
          validator: valid,
          autocorrect: false,
          style: const TextStyle(
            color: AppColor.grey,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColor.backgroundButton,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w, vertical: 14.h), // Adjust inner padding
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(8.r), // Set border-radius to 8px
              borderSide: BorderSide(
                  width: 1.w,
                  color: AppColor.backgroundButton), // Set border width to 1px
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide:
                  BorderSide(width: 1.w, color: AppColor.backgroundColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide:
                  BorderSide(width: 1.5.w, color: AppColor.backgroundColor),
            ),
            hintText: hintText,
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(width: 10.w),
                Image.asset(
                  prefixIcon, // Ensure this is a valid image path string
                  height: 22.h, // Adjust size as needed
                  width: 22.w,
                ),
                Container(
                  height: 20.h, // Line height
                  width: 2.w, // Line width
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  color: AppColor.backgroundicons, // Line color
                ),
              ],
            ),

            suffixIcon: suffixIcon != null
                ? InkWell(
                    onTap: suffixPressed,
                    child: Image.asset(
                      suffixIcon!, // Ensure this is a valid image path string
                      height: 22.h, // Adjust size as needed
                      width: 22.w,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
// Padding(
//       padding: EdgeInsets.only(bottom: 20.h, right: 5.w, left: 5.w),
//       child: TextFormField(
//         controller: myController,
//         keyboardType: type,
//         obscureText: obSecure,
//         validator: valid,
//         autocorrect: false,
//         style: const TextStyle(
//           color: AppColor.grey,
//         ),
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           hintText: hintText,
//           prefixIcon: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SizedBox(width: 10.w),
//               Icon(
//                 prefixIcon,
//                 color: AppColor.grey,
//               ),
//               Container(
//                 height: 20.h, // Adjust the height of the line as needed
//                 width: 2.w, // Adjust the width of the line as needed
//                 margin: EdgeInsets.symmetric(horizontal: 8.w),
//                 color: AppColor.grey, // Color of the line
//               ),
//             ],
//           ),
//           suffixIcon: suffixIcon != null
//               ? InkWell(
//                   onTap: suffixPressed,
//                   child: Icon(
//                     suffixIcon,
//                     color: AppColor.grey,
//                   ),
//                 )
//               : null,
//         ),
//       ),
//     );