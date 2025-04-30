// import 'package:easycut/core/utils/colors.dart';
// import 'package:easycut/core/utils/dimensions.dart';
// import 'package:easycut/core/view_model/home_view_model.dart';
// import 'package:easycut/core/shared/widgets/big_text.dart';
// import 'package:easycut/core/widgets/small_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class BookSalonView extends GetWidget<HomeViewModel> {
//   const BookSalonView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//         ),
//         title: Text(
//           'Book Now',
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(Dimensions.height15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const BigText(
//               text: "Name",
//             ),
//             SizedBox(height: Dimensions.height10),
//             SmallText(
//               text: 'Amr Abdalfatah',
//               size: Dimensions.font20,
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
//               height: 1,
//               color: Colors.grey,
//             ),
//             const BigText(
//               text: "Salon Name",
//             ),
//             SizedBox(height: Dimensions.height10),
//             SmallText(
//               text: 'Salon Mohamed',
//               size: Dimensions.font20,
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
//               height: 1,
//               color: Colors.grey,
//             ),
//             const BigText(
//               text: "Choose Chair",
//             ),
//             SizedBox(height: Dimensions.height10),
//             GetBuilder<HomeViewModel>(
//               builder: (chairController) {
//                 return SizedBox(
//                   height: Dimensions.height45,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: 5,
//                     itemBuilder: (context, index) {
//                       return GestureDetector(
//                         onTap: () {
//                           chairController.selectChair(index);
//                         },
//                         child: Container(
//                           height: Dimensions.height45,
//                           padding: EdgeInsets.symmetric(
//                             horizontal: Dimensions.width10,
//                           ),
//                           margin: EdgeInsets.symmetric(
//                             horizontal: Dimensions.width5,
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(
//                               Dimensions.radius15,
//                             ),
//                             color: chairController.status[index]
//                                 ? AppColors.mainColor
//                                 : Colors.grey[400],
//                           ),
//                           child: Center(
//                             child: SmallText(
//                               text: "Chair ${index + 1}",
//                               color: chairController.status[index]
//                                   ? Colors.white
//                                   : Colors.black,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
//               height: 1,
//               color: Colors.grey,
//             ),
//             const BigText(
//               text: "Choose Date",
//             ),
//             SizedBox(height: Dimensions.height10),
//             GetBuilder<HomeViewModel>(
//               builder: (dateController) {
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SmallText(
//                       text: dateController.chosenDate,
//                       size: Dimensions.font20,
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         showDatePicker(
//                           context: context,
//                           initialDate: DateTime.now(),
//                           firstDate: DateTime.now(),
//                           lastDate: DateTime(2024),
//                         ).then((value) {
//                           // 2023-08-16 00:00:00.000 -> 2023-08-16
//                           var date = value.toString().substring(0, 10);
//                           dateController.changeChosenDate(date);
//                         }).catchError((error) {
//                           print(error);
//                         });
//                       },
//                       child: SmallText(
//                         text: "Choose",
//                         color: AppColors.mainColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
//               height: 1,
//               color: Colors.grey,
//             ),
//             const BigText(
//               text: "Choose Time",
//             ),
//             SizedBox(height: Dimensions.height10),
//             GetBuilder<HomeViewModel>(
//               builder: (timeController) {
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SmallText(
//                       text: timeController.chosenTime,
//                       size: Dimensions.font20,
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         showTimePicker(
//                           context: context,
//                           initialTime: TimeOfDay.now(),
//                         ).then((value) {
//                           // TimeOfDay(15:37) -> 15:37
//                           var time = value.toString().substring(10, 15);
//                           timeController.changeChosenTime(time);
//                         }).catchError((error) {
//                           print(error);
//                         });
//                       },
//                       child: SmallText(
//                         text: "Choose",
//                         color: AppColors.mainColor,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
//               height: 1,
//               color: Colors.grey,
//             ),
//             const BigText(
//               text: "Choose Services",
//             ),
//             SizedBox(height: Dimensions.height10),
//             Expanded(
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 5,
//                 itemBuilder: (context, index) {
//                   return GestureDetector(
//                     onTap: () {},
//                     child: Container(
//                       width: Dimensions.width200,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: Dimensions.width10,
//                       ),
//                       margin: EdgeInsets.symmetric(
//                         horizontal: Dimensions.width5,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(
//                           Dimensions.radius15,
//                         ),
//                         color: Colors.grey[400],
//                       ),
//                       child: Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             BigText(
//                               text: "Hair Cut",
//                               size: Dimensions.font16,
//                             ),
//                             SizedBox(height: Dimensions.height15),
//                             SmallText(
//                               text: "\$ 50.00 EG",
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: Dimensions.height10),
//               height: 1,
//               color: Colors.grey,
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: GestureDetector(
//         onTap: () {
//           Get.defaultDialog(
//             title: "Book Now",
//             content: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     BigText(text: "Name:"),
//                     SizedBox(width: Dimensions.width10),
//                     SmallText(
//                       text: "Amr Abdalfatah",
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     BigText(text: "Salon:"),
//                     SizedBox(width: Dimensions.width10),
//                     SmallText(
//                       text: "Salon Mohamed",
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     BigText(text: "Chair:"),
//                     SizedBox(width: Dimensions.width10),
//                     SmallText(
//                       text: "Chair 1",
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     BigText(text: "Date:"),
//                     SizedBox(width: Dimensions.width10),
//                     SmallText(
//                       text: controller.chosenDate,
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     BigText(text: "Time:"),
//                     SizedBox(width: Dimensions.width10),
//                     SmallText(
//                       text: controller.chosenTime,
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     BigText(text: "Services:"),
//                     SizedBox(width: Dimensions.width10),
//                     SmallText(
//                       text: "Hair Cut",
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     BigText(text: "Amount:"),
//                     SizedBox(width: Dimensions.width10),
//                     SmallText(
//                       text: "\$ 100.00 EG",
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Get.snackbar(
//                     "Success",
//                     "you have booked successfully, \nbut you still wait for accepting from salon",
//                     colorText: Colors.green,
//                     snackPosition: SnackPosition.TOP,
//                   );
//                 },
//                 child: Text(
//                   'Confirm',
//                   style: TextStyle(
//                     color: AppColors.mainColor,
//                   ),
//                 ),
//               ),
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text(
//                   'Cancel',
//                   style: TextStyle(
//                     color: Colors.red,
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//         child: Container(
//           height: Dimensions.height60,
//           padding: EdgeInsets.symmetric(vertical: Dimensions.height10),
//           color: AppColors.mainColor,
//           child: BigText(
//             text: "Submit",
//             color: Colors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }
