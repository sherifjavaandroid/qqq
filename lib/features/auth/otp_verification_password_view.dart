// import 'package:easycut/core/utils/colors.dart';
// import 'package:easycut/core/utils/dimensions.dart';
// import 'package:easycut/core/view_model/auth_view_model.dart';
// import 'package:easycut/core/widgets/main_button.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// import '../../view/widget/auth/header_auth.dart';
// import 'change_password_view.dart';
//
// class OtpVerificationPasswordView extends GetWidget<AuthViewModel> {
//   const OtpVerificationPasswordView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           height: Dimensions.screenHeight,
//           padding: EdgeInsets.symmetric(
//             horizontal: Dimensions.width15,
//             vertical: Dimensions.height15,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               const HeaderAuth(
//                 title: "OTP Verification!",
//                 firstDesc: "Check your email.",
//                 secondDesc: "We've sent you the PIN in your email.",
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   PinCodeTextField(
//                     appContext: context,
//                     pastedTextStyle: const TextStyle(
//                       color: AppColors.mainColor,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     length: 6,
//                     animationType: AnimationType.fade,
//                     validator: (v) {
//                       if (v!.length < 6) {
//                         return "Enter Full Number";
//                       } else {
//                         return null;
//                       }
//                     },
//                     pinTheme: PinTheme(
//                       shape: PinCodeFieldShape.box,
//                       borderRadius: BorderRadius.circular(5),
//                       fieldHeight: Dimensions.height50,
//                       fieldWidth: Dimensions.width45,
//                       activeFillColor: Colors.white,
//                       inactiveColor: Colors.white,
//                       disabledColor: Colors.white,
//                       inactiveFillColor: Colors.white,
//                       activeColor: Colors.white,
//                       selectedColor: Colors.white,
//                       selectedFillColor: Colors.white,
//                     ),
//                     cursorColor: Colors.black,
//                     animationDuration: const Duration(milliseconds: 300),
//                     enableActiveFill: true,
//                     keyboardType: TextInputType.number,
//                     onChanged: (value) {},
//                   ),
//                   MainButton(
//                     text: 'Verify',
//                     onTap: () {
//                       Get.to(() => const ChangePasswordView());
//                     },
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
