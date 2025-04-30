// import 'package:easycut/controller/home/booking_screen_controller.dart';
// import 'package:easycut/core/class/handling_data_view.dart';
// import 'package:easycut/core/class/status_request.dart';
// import 'package:easycut/core/constant/color.dart';
// import 'package:easycut/core/constant/routes.dart';
// import 'package:easycut/core/shared/widgets/big_text.dart';
// import 'package:easycut/core/shared/widgets/small_text.dart';
// import 'package:easycut/linkapi.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../core/constant/dimensions.dart';

// class BookingView extends StatelessWidget {
//   const BookingView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut(() => BookingScreenControllerImp());
//     return WillPopScope(
//       onWillPop: () async {
//         Navigator.of(context).pushNamedAndRemoveUntil(
//           AppRoute.home,
//           (Route<dynamic> route) => false,
//         );
//         return false;
//       },
//       child: SafeArea(
//         child: GetBuilder<BookingScreenControllerImp>(
//           builder: (controller) {
//             return HandlingDataView(
//               statusRequest: StatusRequest.success, // Update as needed
//               widget: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: Dimensions.width10),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: Dimensions.height50,
//                       width: double.infinity,
//                       child: const Center(
//                         child: BigText(
//                           text: "All Bookings",
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: Dimensions.height20),
//                     Expanded(
//                       child: controller.bookings.isEmpty
//                           ? const Center(
//                               child: BigText(
//                                 text: "No bookings available",
//                                 color: AppColor.primaryColor,
//                               ),
//                             )
//                           : ListView.separated(
//                               scrollDirection: Axis.vertical,
//                               itemBuilder: (context, index) {
//                                 final booking = controller.bookings[index];
//                                 return SizedBox(
//                                   height: Dimensions.height350 +
//                                       Dimensions.height10,
//                                   width: double.infinity,
//                                   child: Card(
//                                     child: Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         SizedBox(
//                                           height: Dimensions.height150,
//                                           width: double.infinity,
//                                           child: ClipRRect(
//                                             borderRadius: BorderRadius.circular(
//                                                 Dimensions.radius5),
//                                             child: booking.image != null
//                                                 ? Image.network(
//                                                     "${AppLink.imageSalons}${booking.image}",
//                                                     fit: BoxFit.fitWidth,
//                                                     errorBuilder: (context,
//                                                         error, stackTrace) {
//                                                       return const Center(
//                                                         child: Icon(
//                                                           Icons
//                                                               .image_not_supported,
//                                                           size: 50,
//                                                           color: Colors.grey,
//                                                         ),
//                                                       );
//                                                     },
//                                                   )
//                                                 : const Center(
//                                                     child: Icon(
//                                                       Icons.image_not_supported,
//                                                       size: 50,
//                                                       color: Colors.grey,
//                                                     ),
//                                                   ),
//                                           ),
//                                         ),
//                                         SizedBox(height: Dimensions.height10),
//                                         Padding(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: Dimensions.width10),
//                                           child: Column(
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.start,
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   SmallText(
//                                                     text: "Salon Name: ",
//                                                     size: Dimensions.font16,
//                                                   ),
//                                                   BigText(
//                                                     text: booking.name ?? '',
//                                                     color:
//                                                         AppColor.primaryColor,
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                   height: Dimensions.height10),
//                                               Row(
//                                                 children: [
//                                                   SmallText(
//                                                     text: "Salon Email: ",
//                                                     size: Dimensions.font16,
//                                                   ),
//                                                   BigText(
//                                                     text: booking.email ?? '',
//                                                     color:
//                                                         AppColor.primaryColor,
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                   height: Dimensions.height10),
//                                               Row(
//                                                 children: [
//                                                   SmallText(
//                                                     text: "Salon Phone: ",
//                                                     size: Dimensions.font16,
//                                                   ),
//                                                   BigText(
//                                                     text: booking.phone ?? '',
//                                                     color:
//                                                         AppColor.primaryColor,
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                   height: Dimensions.height10),
//                                               Row(
//                                                 children: [
//                                                   SmallText(
//                                                     text: "Chair: ",
//                                                     size: Dimensions.font16,
//                                                   ),
//                                                   BigText(
//                                                     text: booking.chair ?? '',
//                                                     color:
//                                                         AppColor.primaryColor,
//                                                   ),
//                                                   SizedBox(
//                                                       width:
//                                                           Dimensions.width10),
//                                                   SmallText(
//                                                     text: "Day: ",
//                                                     size: Dimensions.font16,
//                                                   ),
//                                                   BigText(
//                                                     text: booking.day ?? '',
//                                                     color:
//                                                         AppColor.primaryColor,
//                                                   ),
//                                                   SizedBox(
//                                                       width:
//                                                           Dimensions.width10),
//                                                   SmallText(
//                                                     text: "Time: ",
//                                                     size: Dimensions.font16,
//                                                   ),
//                                                   BigText(
//                                                     text: booking.time ?? '',
//                                                     color:
//                                                         AppColor.primaryColor,
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                   height: Dimensions.height10),
//                                               Row(
//                                                 children: [
//                                                   SmallText(
//                                                     text: "Total: ",
//                                                     size: Dimensions.font16,
//                                                   ),
//                                                   BigText(
//                                                     text:
//                                                         "${booking.total ?? ''} \$",
//                                                     color:
//                                                         AppColor.primaryColor,
//                                                   ),
//                                                   SizedBox(
//                                                       width:
//                                                           Dimensions.width20),
//                                                   SmallText(
//                                                     text: "Status: ",
//                                                     size: Dimensions.font16,
//                                                   ),
//                                                   SizedBox(
//                                                       width: Dimensions.width5),
//                                                   _buildStatusIndicator(booking
//                                                       .approve as String?),
//                                                 ],
//                                               ),
//                                               SizedBox(
//                                                   height: Dimensions.height20),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                               separatorBuilder: (context, index) {
//                                 return SizedBox(height: Dimensions.height20);
//                               },
//                               itemCount: controller.bookings.length,
//                             ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildStatusIndicator(String? approve) {
//     if (approve == "0") {
//       return Row(
//         children: [
//           Container(
//             height: Dimensions.height20,
//             width: Dimensions.height20,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.orange,
//             ),
//           ),
//           SizedBox(width: Dimensions.width5),
//           const BigText(
//             text: "Waiting",
//             color: Colors.orange,
//           )
//         ],
//       );
//     } else if (approve == "1") {
//       return Row(
//         children: [
//           Container(
//             height: Dimensions.height20,
//             width: Dimensions.height20,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.green,
//             ),
//           ),
//           SizedBox(width: Dimensions.width5),
//           const BigText(
//             text: "Accepted",
//             color: Colors.green,
//           )
//         ],
//       );
//     } else {
//       return Row(
//         children: [
//           Container(
//             height: Dimensions.height20,
//             width: Dimensions.height20,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.red,
//             ),
//           ),
//           SizedBox(width: Dimensions.width5),
//           const BigText(
//             text: "Refused",
//             color: Colors.red,
//           )
//         ],
//       );
//     }
//   }
// }
