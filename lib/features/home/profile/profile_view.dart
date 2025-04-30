// import 'package:easycut/core/constant/image_asset.dart';
// import 'package:easycut/core/utils/dimensions.dart';
// import 'package:easycut/core/shared/widgets/big_text.dart';
// import 'package:easycut/core/widgets/small_text.dart';
// import 'package:easycut/features/home/widgets/expandable_text_widget.dart';
// import 'package:flutter/material.dart';
//
// class ProfileView extends StatelessWidget {
//   const ProfileView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
//         child: Column(
//           children: [
//             Container(
//               height: Dimensions.height150,
//               child: Card(
//                 child: Padding(
//                   padding: EdgeInsets.all(Dimensions.height15),
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: Dimensions.height100,
//                         child: Row(
//                           children: [
//                             CircleAvatar(
//                               radius: Dimensions.radius50,
//                               backgroundImage: AssetImage(
//                                 AppImageAsset.profile,
//                               ),
//                             ),
//                             SizedBox(width: Dimensions.width20),
//                             Expanded(
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Expanded(
//                                         child: BigText(
//                                           text: "Amr Abdalfatah",
//                                         ),
//                                       ),
//                                       SizedBox(width: Dimensions.width5),
//                                       IconButton(
//                                         onPressed: () {},
//                                         icon: Icon(Icons.edit),
//                                       ),
//                                     ],
//                                   ),
//                                   SmallText(text: "amr@gmail.com")
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: DefaultTabController(
//                 length: 2,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TabBar(
//                       labelColor: Colors.black,
//                       tabs: [
//                         Tab(
//                           text: "About",
//                         ),
//                         Tab(
//                           text: "Favorites",
//                         ),
//                       ],
//                     ),
//                     Expanded(
//                       child: TabBarView(
//                         children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: Dimensions.height20),
//                               BigText(text: "About"),
//                               SizedBox(height: Dimensions.height10),
//                               SizedBox(
//                                 height: Dimensions.height120,
//                                 child: SingleChildScrollView(
//                                   child: ExpandableTextWidget(
//                                     text:
//                                         "Hello My name is Amr Abdalfatah \nI'm Software Developer \nWorking as freelancer",
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: Dimensions.height10),
//                               BigText(text: "Phone Number"),
//                               SizedBox(height: Dimensions.height10),
//                               SmallText(text: "+201016716496"),
//                               SizedBox(height: Dimensions.height20),
//                               BigText(text: "Address"),
//                               SizedBox(height: Dimensions.height10),
//                               SmallText(
//                                   text: "Tanesha - Birket Elsabaa - ElMenofia"),
//                             ],
//                           ),
//                           GridView.builder(
//                             padding: EdgeInsets.symmetric(
//                               vertical: Dimensions.height20,
//                             ),
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2,
//                               mainAxisSpacing: Dimensions.height15,
//                               crossAxisSpacing: Dimensions.height15,
//                               childAspectRatio: 3 / 4,
//                             ),
//                             itemCount: 4,
//                             itemBuilder: (context, index) {
//                               return Container(
//                                 color: Colors.red,
//                               );
//                               // return Card(
//                               //   margin: EdgeInsets.only(
//                               //     bottom: Dimensions.height15,
//                               //   ),
//                               //   child: Container(
//                               //     height: Dimensions.height150,
//                               //     padding: EdgeInsets.all(Dimensions.height15),
//                               //     child: Column(
//                               //       crossAxisAlignment: CrossAxisAlignment.start,
//                               //       children: [
//                               //         ListTile(
//                               //           leading: CircleAvatar(
//                               //             radius: Dimensions.radius30,
//                               //             backgroundImage: AssetImage(
//                               //               'assets/images/salonbk/salon1.jpg',
//                               //             ),
//                               //           ),
//                               //           title: BigText(
//                               //             text: "Amr Abdalfatah",
//                               //           ),
//                               //           subtitle: SmallText(
//                               //             text: "20 Minutes Ago",
//                               //           ),
//                               //           trailing: SizedBox(
//                               //             width: Dimensions.width45,
//                               //             child: Row(
//                               //               children: [
//                               //                 Icon(
//                               //                   Icons.star,
//                               //                   size: Dimensions.width15,
//                               //                   color: Colors.yellow,
//                               //                 ),
//                               //                 SmallText(
//                               //                   text: "5.00",
//                               //                   color: Colors.black45,
//                               //                 ),
//                               //               ],
//                               //             ),
//                               //           ),
//                               //         ),
//                               //         Container(
//                               //           height: 1,
//                               //           color: Colors.grey[300],
//                               //         ),
//                               //         SizedBox(
//                               //           height: Dimensions.height10,
//                               //         ),
//                               //         Expanded(
//                               //           child: SmallText(
//                               //             text: "Hiiiiiiiiiiiiiiiiii\nHello My name ",
//                               //             color: Colors.black45,
//                               //           ),
//                               //         ),
//                               //       ],
//                               //     ),
//                               //   ),
//                               // );
//                             },
//                           ),
//                         ],
//                       ),
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
