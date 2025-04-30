// import 'package:easycut/core/constant/image_asset.dart';
// import 'package:easycut/core/utils/dimensions.dart';
// import 'package:easycut/core/shared/widgets/big_text.dart';
// import 'package:easycut/core/widgets/small_text.dart';
// import 'package:easycut/features/home/main/book_salon_view.dart';
// import 'package:easycut/features/home/widgets/days_choice_booking.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ShowSalonBookingView extends StatefulWidget {
//   const ShowSalonBookingView({super.key});
//
//   @override
//   State<ShowSalonBookingView> createState() => _ShowSalonBookingViewState();
// }
//
// class _ShowSalonBookingViewState extends State<ShowSalonBookingView> {
//   PageController _page = PageController();
//   int selected = 0;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   void changePage(int num) {
//     setState(() {
//       _page.animateToPage(
//         num,
//         duration: Duration(milliseconds: 400),
//         curve: Curves.easeIn,
//       );
//       selected = num;
//     });
//   }
//
//   @override
//   void dispose() {
//     _page.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: const Text(
//           'Salons Booking',
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             color: Colors.black,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Get.to(() => BookSalonView());
//             },
//             icon: Icon(
//               Icons.add,
//               color: Colors.black,
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           DaysChoiceBooking(),
//           SizedBox(height: Dimensions.height10),
//           Expanded(
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: Dimensions.width100,
//                   child: ListView(
//                     children: [
//                       Container(
//                         height: 1,
//                         color: Colors.grey,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           changePage(0);
//                         },
//                         child: Container(
//                           height: Dimensions.height100,
//                           color: selected == 0 ? Colors.blue : Colors.white,
//                           child: Center(
//                             child: Text(
//                               "Chair One",
//                               style: TextStyle(
//                                 color:
//                                     selected == 0 ? Colors.white : Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 1,
//                         color: Colors.grey,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           changePage(1);
//                         },
//                         child: Container(
//                           height: Dimensions.height100,
//                           color: selected == 1 ? Colors.blue : Colors.white,
//                           child: Center(
//                             child: Text(
//                               "Chair Two",
//                               style: TextStyle(
//                                 color:
//                                     selected == 1 ? Colors.white : Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 1,
//                         color: Colors.grey,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           changePage(2);
//                         },
//                         child: Container(
//                           height: Dimensions.height100,
//                           color: selected == 2 ? Colors.blue : Colors.white,
//                           child: Center(
//                             child: Text(
//                               "Chair Three",
//                               style: TextStyle(
//                                 color:
//                                     selected == 2 ? Colors.white : Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 1,
//                         color: Colors.grey,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           changePage(3);
//                         },
//                         child: Container(
//                           height: Dimensions.height100,
//                           color: selected == 3 ? Colors.blue : Colors.white,
//                           child: Center(
//                             child: Text(
//                               "Chair Four",
//                               style: TextStyle(
//                                 color:
//                                     selected == 3 ? Colors.white : Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 1,
//                         color: Colors.grey,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           changePage(4);
//                         },
//                         child: Container(
//                           height: Dimensions.height100,
//                           color: selected == 4 ? Colors.blue : Colors.white,
//                           child: Center(
//                             child: Text(
//                               "Chair Five",
//                               style: TextStyle(
//                                 color:
//                                     selected == 4 ? Colors.white : Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 1,
//                         color: Colors.grey,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: PageView(
//                     scrollDirection: Axis.vertical,
//                     controller: _page,
//                     physics: NeverScrollableScrollPhysics(),
//                     children: [
//                       Column(
//                         children: [
//                           Card(
//                             child: Padding(
//                               padding: EdgeInsets.all(Dimensions.height15),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                         radius: Dimensions.radius30,
//                                         backgroundImage: AssetImage(
//                                           AppImageAsset.profile,
//                                         ),
//                                       ),
//                                       SizedBox(width: Dimensions.width10),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             BigText(
//                                               text: "Amr Abdalfatah",
//                                             ),
//                                             SizedBox(
//                                               height: Dimensions.height10,
//                                             ),
//                                             SmallText(
//                                               text: "8:00 PM - 9:00 PM",
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Card(
//                             child: Padding(
//                               padding: EdgeInsets.all(Dimensions.height15),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                         radius: Dimensions.radius30,
//                                         backgroundImage: AssetImage(
//                                           AppImageAsset.profile,
//                                         ),
//                                       ),
//                                       SizedBox(width: Dimensions.width10),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             BigText(
//                                               text: "Mohamed Ibrahim",
//                                             ),
//                                             SizedBox(
//                                               height: Dimensions.height10,
//                                             ),
//                                             SmallText(
//                                               text: "9:00 PM - 10:00 PM",
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Card(
//                             child: Padding(
//                               padding: EdgeInsets.all(Dimensions.height15),
//                               child: Column(
//                                 children: [
//                                   Row(
//                                     children: [
//                                       CircleAvatar(
//                                         radius: Dimensions.radius30,
//                                         backgroundImage: AssetImage(
//                                           AppImageAsset.profile,
//                                         ),
//                                       ),
//                                       SizedBox(width: Dimensions.width10),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             BigText(
//                                               text: "Ahmed Mohamed Shatla",
//                                             ),
//                                             SizedBox(
//                                               height: Dimensions.height10,
//                                             ),
//                                             SmallText(
//                                                 text: "10:00 PM - 11:00 PM"),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Center(
//                         child: Text("Chair two"),
//                       ),
//                       Center(
//                         child: Text("Chair three"),
//                       ),
//                       Center(
//                         child: Text("Chair Four"),
//                       ),
//                       Center(
//                         child: Text("Chair five"),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
