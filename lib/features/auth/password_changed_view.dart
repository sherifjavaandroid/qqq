// import 'package:easycut/core/constant/image_asset.dart';
// import 'package:easycut/core/utils/colors.dart';
// import 'package:easycut/core/utils/dimensions.dart';
// import 'package:easycut/core/view_model/auth_view_model.dart';
// import 'package:easycut/core/shared/widgets/big_text.dart';
// import 'package:easycut/core/widgets/main_button.dart';
// import 'package:easycut/core/widgets/small_text.dart';
// import 'package:easycut/view/screen/auth/login.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class PasswordChangedView extends StatelessWidget {
//   const PasswordChangedView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: Dimensions.screenHeight,
//         padding: EdgeInsets.symmetric(
//           horizontal: Dimensions.width15,
//           vertical: Dimensions.height15,
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: Dimensions.heightImage,
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.fill,
//                   image: AssetImage(AppImageAsset.logo),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: Dimensions.height30,
//             ),
//             Icon(
//               Icons.done_rounded,
//               size: Dimensions.height64,
//               color: AppColors.mainColor,
//             ),
//             BigText(
//               text: 'Password Changed!',
//               fontWeight: FontWeight.w700,
//               size: Dimensions.font32,
//               color: const Color(0xFF1E232C),
//             ),
//             SizedBox(
//               height: Dimensions.height10,
//             ),
//             SmallText(
//               text: 'Your password has been changed \nsuccessfully.',
//               textAlign: TextAlign.center,
//               fontWeight: FontWeight.w500,
//               size: Dimensions.font16,
//               color: const Color(0xFF8391A1),
//             ),
//             SizedBox(
//               height: Dimensions.height45,
//             ),
//             MainButton(
//               text: 'Back to Login',
//               onTap: () {
//                 Get.offAll(() => Login());
//                 Get.put(() => AuthViewModel());
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
