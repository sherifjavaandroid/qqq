// import 'package:easycut/core/utils/colors.dart';
// import 'package:easycut/core/utils/dimensions.dart';
// import 'package:easycut/core/view_model/auth_view_model.dart';
// import 'package:easycut/core/widgets/main_button.dart';
// import 'package:easycut/features/auth/password_changed_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../view/widget/auth/header_auth.dart';
//
// class ChangePasswordView extends GetWidget<AuthViewModel> {
//   const ChangePasswordView({Key? key}) : super(key: key);
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
//                 title: "Reset Password",
//                 firstDesc: "make your account secure ,",
//                 secondDesc: "Create a new password and confirm it.",
//               ),
//               GetX<AuthViewModel>(
//                 builder: (authCTRL) => TextFormField(
//                   keyboardType: TextInputType.visiblePassword,
//                   style: const TextStyle(
//                     color: AppColors.mainColor,
//                   ),
//                   obscureText: authCTRL.shownPassword.value,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(
//                         Dimensions.radius20,
//                       ),
//                     ),
//                     hintText: "Password",
//                     prefixIcon: const Icon(
//                       Icons.lock,
//                       color: AppColors.mainColor,
//                     ),
//                     suffixIcon: IconButton(
//                       onPressed: () {
//                         controller.changeShownPassword();
//                       },
//                       icon: Icon(
//                         controller.shownPassword.value
//                             ? Icons.remove_red_eye_rounded
//                             : Icons.visibility_off,
//                         color: AppColors.mainColor,
//                       ),
//                     ),
//                   ),
//                   onSaved: (value) {
//                     controller.password = value!;
//                   },
//                   validator: (value) {
//                     if (controller.password.isEmpty) {
//                       return 'Please, Enter your Password';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: Dimensions.height10,
//               ),
//               GetX<AuthViewModel>(
//                 builder: (authCTRL) => TextFormField(
//                   keyboardType: TextInputType.visiblePassword,
//                   style: TextStyle(
//                     color: AppColors.mainColor,
//                   ),
//                   obscureText: authCTRL.shownPassword.value,
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(
//                         Dimensions.radius20,
//                       ),
//                     ),
//                     hintText: "Confirm Password",
//                     prefixIcon: const Icon(
//                       Icons.lock,
//                       color: AppColors.mainColor,
//                     ),
//                     suffixIcon: IconButton(
//                       onPressed: () {
//                         controller.changeShownPassword();
//                       },
//                       icon: Icon(
//                         controller.shownPassword.value
//                             ? Icons.remove_red_eye_rounded
//                             : Icons.visibility_off,
//                         color: AppColors.mainColor,
//                       ),
//                     ),
//                   ),
//                   onSaved: (value) {
//                     controller.password = value!;
//                   },
//                   validator: (value) {
//                     if (controller.password.isEmpty) {
//                       return 'Please, Enter your Password';
//                     }
//                     return null;
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: Dimensions.height10,
//               ),
//               MainButton(
//                 text: 'Reset Password',
//                 onTap: () {
//                   Get.to(() => const PasswordChangedView());
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
