// import 'package:easycut/core/utils/colors.dart';
// import 'package:easycut/core/utils/dimensions.dart';
// import 'package:easycut/core/view_model/auth_view_model.dart';
// import 'package:easycut/core/widgets/small_text.dart';
// import 'package:easycut/view/screen/auth/login.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../view/widget/auth/header_auth.dart';
//
// class RegisterEmailPasswordView extends GetWidget<AuthViewModel> {
//   RegisterEmailPasswordView({Key? key}) : super(key: key);
//
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 const HeaderAuth(
//                   title: "Register Now",
//                   firstDesc: "So happy to see you,",
//                   secondDesc: "Let's make your life easy.",
//                 ),
//                 TextFormField(
//                   keyboardType: TextInputType.text,
//                   style: TextStyle(
//                     color: AppColors.mainColor,
//                   ),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(
//                         Dimensions.radius20,
//                       ),
//                     ),
//                     hintText: "Name",
//                     prefixIcon: const Icon(
//                       Icons.person,
//                       color: AppColors.mainColor,
//                     ),
//                   ),
//                   onSaved: (value) {
//                     controller.name = value!;
//                   },
//                   validator: (value) {
//                     if (controller.name.isEmpty) {
//                       return 'Please, Enter your Name';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: Dimensions.height10),
//                 TextFormField(
//                   keyboardType: TextInputType.phone,
//                   style: TextStyle(
//                     color: AppColors.mainColor,
//                   ),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(
//                         Dimensions.radius20,
//                       ),
//                     ),
//                     hintText: "Phone Number",
//                     prefixIcon: const Icon(
//                       Icons.phone,
//                       color: AppColors.mainColor,
//                     ),
//                   ),
//                   onSaved: (value) {
//                     controller.phone = value!;
//                   },
//                   validator: (value) {
//                     if (controller.phone.isEmpty) {
//                       return 'Please, Enter your Phone';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: Dimensions.height10),
//                 TextFormField(
//                   keyboardType: TextInputType.emailAddress,
//                   style: TextStyle(
//                     color: AppColors.mainColor,
//                   ),
//                   decoration: InputDecoration(
//                     filled: true,
//                     fillColor: Colors.white,
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(
//                         Dimensions.radius20,
//                       ),
//                     ),
//                     hintText: "Email",
//                     prefixIcon: const Icon(
//                       Icons.email,
//                       color: AppColors.mainColor,
//                     ),
//                   ),
//                   onSaved: (value) {
//                     controller.email = value!;
//                   },
//                   validator: (value) {
//                     final regex = RegExp(
//                         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
//                     if (controller.email.isEmpty) {
//                       return 'Please, Enter your Email';
//                     } else if (!regex.hasMatch(value!)) {
//                       return 'Your Email is not valid';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: Dimensions.height10),
//                 // Enter Password
//                 GetX<AuthViewModel>(
//                   builder: (authCTRL) => TextFormField(
//                     keyboardType: TextInputType.visiblePassword,
//                     style: TextStyle(
//                       color: AppColors.mainColor,
//                     ),
//                     obscureText: authCTRL.shownPassword.value,
//                     decoration: InputDecoration(
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(
//                           Dimensions.radius20,
//                         ),
//                       ),
//                       hintText: "Password",
//                       prefixIcon: const Icon(
//                         Icons.lock,
//                         color: AppColors.mainColor,
//                       ),
//                       suffixIcon: IconButton(
//                         onPressed: () {
//                           controller.changeShownPassword();
//                         },
//                         icon: Icon(
//                           controller.shownPassword.value
//                               ? Icons.remove_red_eye_rounded
//                               : Icons.visibility_off,
//                           color: AppColors.mainColor,
//                         ),
//                       ),
//                     ),
//                     onSaved: (value) {
//                       controller.password = value!;
//                     },
//                     validator: (value) {
//                       if (controller.password.isEmpty) {
//                         return 'Please, Enter your Password';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//                 SizedBox(height: Dimensions.height10),
//                 GetX<AuthViewModel>(
//                   builder: (process) {
//                     return process.action.value
//                         ? const Center(
//                             child: CupertinoActivityIndicator(
//                               color: AppColors.mainColor,
//                             ),
//                           )
//                         : GestureDetector(
//                             onTap: () {
//                               _formKey.currentState!.save();
//                               if (_formKey.currentState!.validate()) {
//                                 Get.offAll(() => Login());
//                                 Get.put(() => AuthViewModel());
//                               }
//                             },
//                             child: Center(
//                               child: Container(
//                                 height: Dimensions.height45,
//                                 decoration: BoxDecoration(
//                                   color: AppColors.mainColor,
//                                   borderRadius: BorderRadius.circular(
//                                     Dimensions.radius30,
//                                   ),
//                                 ),
//                                 child: const Center(
//                                   child: SmallText(
//                                     text: "Sign Up",
//                                     fontWeight: FontWeight.w800,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                   },
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SmallText(
//                       text: "Already have an account? ",
//                       color: Colors.black54,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         Get.back();
//                       },
//                       child: SmallText(
//                         text: "Login",
//                         color: AppColors.mainColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
