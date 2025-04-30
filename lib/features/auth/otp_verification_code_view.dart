// import 'package:easycut/core/utils/dimensions.dart';
// import 'package:easycut/core/shared/widgets/big_text.dart';
// import 'package:easycut/core/widgets/main_button.dart';
// import 'package:easycut/core/widgets/small_text.dart';
// import 'package:flutter/material.dart';
// // import 'package:pin_code_fields/pin_code_fields.dart';
//
// class OtpVerificationCodeView extends StatelessWidget {
//   const OtpVerificationCodeView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox(
//         height: Dimensions.screenHeight,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const BigText(
//               text: "Enter OTP Code",
//             ),
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: Dimensions.width15,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: Dimensions.height64,
//                     ),
//                     BigText(
//                       text: 'OTP Verification',
//                       fontFamily: "Urbanist",
//                       fontWeight: FontWeight.w700,
//                       size: Dimensions.font32,
//                       color: const Color(0xFF1E232C),
//                     ),
//                     SizedBox(
//                       height: Dimensions.height10,
//                     ),
//                     SmallText(
//                       text:
//                           'Enter the verification code we just sent on your \nphone number.',
//                       textAlign: TextAlign.start,
//                       fontFamily: "Urbanist",
//                       fontWeight: FontWeight.w500,
//                       size: Dimensions.font16,
//                       color: const Color(0xFF8391A1),
//                     ),
//                     SizedBox(
//                       height: Dimensions.height30,
//                     ),
//                     // PinCodeTextField(
//                     //   appContext: context,
//                     //   pastedTextStyle: const TextStyle(
//                     //     color: AppColors.mainColor,
//                     //     fontWeight: FontWeight.bold,
//                     //   ),
//                     //   length: 6,
//                     //   animationType: AnimationType.fade,
//                     //   validator: (v) {
//                     //     if (v!.length < 6) {
//                     //       return "Enter Full Number";
//                     //     } else {
//                     //       return null;
//                     //     }
//                     //   },
//                     //   pinTheme: PinTheme(
//                     //     shape: PinCodeFieldShape.box,
//                     //     borderRadius: BorderRadius.circular(5),
//                     //     fieldHeight: Dimensions.height50,
//                     //     fieldWidth: Dimensions.width45,
//                     //     activeFillColor: Colors.white,
//                     //     inactiveColor: Colors.white,
//                     //     disabledColor: Colors.white,
//                     //     inactiveFillColor: Colors.white,
//                     //     activeColor: Colors.white,
//                     //     selectedColor: Colors.white,
//                     //     selectedFillColor: Colors.white,
//                     //   ),
//                     //   cursorColor: Colors.black,
//                     //   animationDuration: const Duration(milliseconds: 300),
//                     //   enableActiveFill: true,
//                     //   keyboardType: TextInputType.number,
//                     //   onChanged: (value) {},
//                     // ),
//                     SizedBox(
//                       height: Dimensions.height30,
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           const SmallText(
//                             text: "Didn't received code? ",
//                             fontFamily: "Urbanist",
//                             fontWeight: FontWeight.w500,
//                             color: Color(0xFF1E232C),
//                           ),
//                           GestureDetector(
//                             onTap: () {},
//                             child: const SmallText(
//                               text: 'Resend',
//                               fontFamily: "Urbanist",
//                               fontWeight: FontWeight.w700,
//                               color: Color(0xFF294F8F),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     MainButton(
//                       text: 'Verify',
//                       onTap: () {
//                         // Get.to(() => const ChangePasswordView());
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
