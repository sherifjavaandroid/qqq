// import 'package:easycut/core/constant/image_asset.dart';
// import 'package:easycut/core/utils/colors.dart';
// import 'package:easycut/core/utils/dimensions.dart';
// import 'package:easycut/core/shared/widgets/big_text.dart';
// import 'package:easycut/core/widgets/small_text.dart';
// import 'package:flutter/material.dart';
//
// class HeaderMainView extends StatelessWidget {
//   const HeaderMainView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         CircleAvatar(
//           radius: Dimensions.radius30,
//           backgroundImage: AssetImage(
//             AppImageAsset.profile,
//           ),
//         ),
//         SizedBox(width: Dimensions.width10),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SmallText(
//               text: "Hello",
//               color: Colors.black,
//               size: Dimensions.font16,
//             ),
//             BigText(
//               text: "Amr Abdalfatah",
//               color: Colors.black,
//               size: Dimensions.font20,
//             ),
//           ],
//         ),
//         Spacer(),
//         Center(
//           child: Container(
//             width: Dimensions.width45,
//             height: Dimensions.height45,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(
//                 Dimensions.radius15,
//               ),
//               color: AppColors.mainColor,
//             ),
//             child: Icon(
//               Icons.menu,
//               color: Colors.white,
//               size: Dimensions.iconSize24,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
