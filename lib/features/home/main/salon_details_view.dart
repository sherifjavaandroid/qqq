// import 'package:easycut/core/utils/colors.dart';
// import 'package:easycut/core/utils/dimensions.dart';
// import 'package:easycut/core/utils/images_strings.dart';
// import 'package:easycut/core/shared/widgets/big_text.dart';
// import 'package:easycut/features/home/main/show_salon_booking_view.dart';
// import 'package:easycut/features/home/widgets/app_icon.dart';
// import 'package:easycut/features/home/widgets/expandable_text_widget.dart';
// import 'package:easycut/features/home/widgets/show_salon_card.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class SalonDetailsView extends StatelessWidget {
//   const SalonDetailsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned(
//             left: 0,
//             right: 0,
//             child: Container(
//               width: double.infinity,
//               height: Dimensions.height350,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage(
//                     ImagesStrings.salonOne,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             left: Dimensions.width20,
//             right: Dimensions.width20,
//             top: Dimensions.height45,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: AppIcon(icon: Icons.arrow_back_ios),
//                 ),
//                 AppIcon(icon: Icons.favorite_border),
//               ],
//             ),
//           ),
//           Positioned(
//             top: Dimensions.height350 - Dimensions.height70,
//             left: 0,
//             right: 0,
//             bottom: 0,
//             child: ListView(
//               children: [
//                 Container(
//                   height: Dimensions.screenHeight - Dimensions.height150,
//                   padding: EdgeInsets.only(
//                     right: Dimensions.width20,
//                     left: Dimensions.width20,
//                     top: Dimensions.height20,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(Dimensions.radius30),
//                       topLeft: Radius.circular(Dimensions.radius30),
//                     ),
//                   ),
//                   child: DefaultTabController(
//                     length: 3,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ShowSalonCard(
//                           text: "Salon Mohamed",
//                         ),
//                         SizedBox(height: Dimensions.height10),
//                         TabBar(
//                           labelColor: AppColors.mainColor,
//                           unselectedLabelColor: Colors.grey[700],
//                           indicatorColor: AppColors.mainColor,
//                           tabs: [
//                             Tab(
//                               text: "About",
//                             ),
//                             Tab(
//                               text: "Products",
//                             ),
//                             Tab(
//                               text: "Comments",
//                             ),
//                           ],
//                         ),
//                         Expanded(
//                           child: TabBarView(
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(height: Dimensions.height10),
//                                   SizedBox(
//                                     height: Dimensions.height100,
//                                     child: SingleChildScrollView(
//                                       child: ExpandableTextWidget(
//                                         text: "Hello there is a description",
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(height: Dimensions.height10),
//                                   BigText(text: "Gallery"),
//                                   SizedBox(height: Dimensions.height10),
//                                   SizedBox(
//                                     height: Dimensions.height100,
//                                     child: ListView.builder(
//                                       scrollDirection: Axis.horizontal,
//                                       physics: NeverScrollableScrollPhysics(),
//                                       shrinkWrap: true,
//                                       itemCount: 6,
//                                       itemBuilder: (context, index) {
//                                         return Container(
//                                           height: Dimensions.height100,
//                                           width: Dimensions.width100,
//                                           margin: EdgeInsets.only(
//                                             right: Dimensions.width10,
//                                           ),
//                                           decoration: BoxDecoration(
//                                             borderRadius: BorderRadius.circular(
//                                               Dimensions.radius15,
//                                             ),
//                                             image: DecorationImage(
//                                               fit: BoxFit.cover,
//                                               image: AssetImage(
//                                                 ImagesStrings.salonFour,
//                                               ),
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                                   SizedBox(height: Dimensions.height10),
//                                 ],
//                               ),
//                               GridView.builder(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: Dimensions.height20,
//                                 ),
//                                 gridDelegate:
//                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2,
//                                   mainAxisSpacing: Dimensions.height15,
//                                   crossAxisSpacing: Dimensions.height15,
//                                   childAspectRatio: 3 / 4,
//                                 ),
//                                 itemCount: 4,
//                                 itemBuilder: (context, index) {
//                                   return Container(
//                                     color: Colors.red,
//                                   );
//                                 },
//                               ),
//                               GridView.builder(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 padding: EdgeInsets.symmetric(
//                                   vertical: Dimensions.height20,
//                                 ),
//                                 gridDelegate:
//                                     SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisCount: 2,
//                                   mainAxisSpacing: Dimensions.height15,
//                                   crossAxisSpacing: Dimensions.height15,
//                                   childAspectRatio: 3 / 4,
//                                 ),
//                                 itemCount: 4,
//                                 itemBuilder: (context, index) {
//                                   return Container(
//                                     color: Colors.green,
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: Container(
//         height: Dimensions.height80,
//         color: AppColors.mainColor,
//         child: Center(
//           child: TextButton(
//             onPressed: () {
//               Get.to(() => ShowSalonBookingView());
//             },
//             child: BigText(
//               text: "Booking Now",
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
