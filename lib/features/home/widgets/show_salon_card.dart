// import 'package:easycut/core/utils/colors.dart';
// import 'package:easycut/core/utils/dimensions.dart';
// import 'package:easycut/core/shared/widgets/big_text.dart';
// import 'package:easycut/core/widgets/small_text.dart';
// import 'package:easycut/features/home/widgets/icon_and_text.dart';
// import 'package:flutter/material.dart';
//
// class ShowSalonCard extends StatelessWidget {
//   final String text;
//   const ShowSalonCard({super.key, required this.text});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         BigText(
//           text: text,
//           size: Dimensions.font26,
//         ),
//         SizedBox(height: Dimensions.height10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Wrap(
//               children: List.generate(
//                 5,
//                 (index) => Icon(
//                   Icons.star,
//                   color: AppColors.mainColor,
//                   size: Dimensions.height15,
//                 ),
//               ),
//             ),
//             SmallText(text: '4.5'),
//             SmallText(text: '1287'),
//             SmallText(text: 'comments'),
//           ],
//         ),
//         SizedBox(height: Dimensions.height10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             IconAndTextWidget(
//               icon: Icons.circle_sharp,
//               text: 'Men',
//               iconColor: AppColors.iconColor1,
//             ),
//             IconAndTextWidget(
//               icon: Icons.location_on,
//               text: '1.7km',
//               iconColor: AppColors.mainColor,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
