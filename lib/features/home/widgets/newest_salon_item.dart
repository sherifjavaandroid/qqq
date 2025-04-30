// import 'package:easycut/core/utils/colors.dart';
// import 'package:easycut/core/utils/dimensions.dart';
// import 'package:easycut/core/utils/images_strings.dart';
// import 'package:easycut/core/shared/widgets/big_text.dart';
// import 'package:easycut/core/widgets/small_text.dart';
// import 'package:easycut/features/home/main/salon_details_view.dart';
// import 'package:easycut/features/home/widgets/icon_and_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class NewestSalonItem extends StatelessWidget {
//   const NewestSalonItem({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Get.to(() => SalonDetailsView());
//       },
//       child: Container(
//         margin: EdgeInsets.only(
//           left: Dimensions.width20,
//           right: Dimensions.width20,
//           bottom: Dimensions.height10,
//         ),
//         child: Row(
//           children: [
//             Container(
//               width: Dimensions.pageViewTextContainer,
//               height: Dimensions.pageViewTextContainer,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(
//                   Dimensions.radius20,
//                 ),
//                 color: Colors.white38,
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage(
//                     ImagesStrings.salonOne,
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: Container(
//                 height: Dimensions.height100,
//                 padding: EdgeInsets.symmetric(
//                   horizontal: Dimensions.width10,
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(Dimensions.radius20),
//                     bottomRight: Radius.circular(Dimensions.radius20),
//                   ),
//                   color: Colors.white,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     BigText(
//                       text: "Salon Mohamed",
//                       color: Colors.black,
//                       size: Dimensions.font20,
//                     ),
//                     SmallText(
//                       text: 'Salon Description',
//                       color: Colors.black,
//                       size: Dimensions.font16,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconAndTextWidget(
//                           icon: Icons.circle_sharp,
//                           text: 'Men',
//                           iconColor: AppColors.secondTextColor,
//                         ),
//                         IconAndTextWidget(
//                           icon: Icons.location_on,
//                           text: '1.7km',
//                           iconColor: AppColors.mainColor,
//                         ),
//                       ],
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
