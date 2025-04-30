// import 'package:dots_indicator/dots_indicator.dart';
// import 'package:easycut/core/utils/colors.dart';
// import 'package:easycut/core/utils/dimensions.dart';
// import 'package:easycut/core/utils/images_strings.dart';
// import 'package:easycut/features/home/main/salon_details_view.dart';
// import 'package:easycut/model/products_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import 'show_salon_card.dart';
//
// class SlidingPopularSalons extends StatefulWidget {
//   const SlidingPopularSalons({super.key});
//
//   @override
//   State<SlidingPopularSalons> createState() => _SlidingPopularSalonsState();
// }
//
// class _SlidingPopularSalonsState extends State<SlidingPopularSalons> {
//   PageController pageController = PageController(viewportFraction: 0.85);
//   var _currentPageValue = 0.0;
//   final _scaleFactor = 0.8;
//   final _height = Dimensions.pageViewContainer;
//
//   List<Product> popularProductsStatic = [
//     Product(
//       totalSize: 4,
//       typeId: 3444,
//       offset: 455,
//       products: [
//         ProductModel(
//           id: 1,
//           name: 'Head & Sholders',
//           description: 'This is the first element for static',
//           price: 24,
//           stars: 5,
//           img: ImagesStrings.salonTwo,
//           location: 'Egypt',
//           createdAt: '23 Feb, 2023',
//           updatedAt: '24 Feb, 2023',
//           typeId: 2,
//         ),
//         ProductModel(
//           id: 2,
//           name: 'Head & Clear',
//           description: 'This is the first element for static',
//           price: 24,
//           stars: 5,
//           img: ImagesStrings.salonTwo,
//           location: 'Egypt',
//           createdAt: '23 Feb, 2023',
//           updatedAt: '24 Feb, 2023',
//           typeId: 2,
//         ),
//       ],
//     ),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     pageController.addListener(() {
//       setState(() {
//         _currentPageValue = pageController.page!;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         SizedBox(
//           height: Dimensions.pageView,
//           child: PageView.builder(
//             controller: pageController,
//             itemCount: popularProductsStatic[0].products.length,
//             itemBuilder: (context, position) {
//               return _buildPageItem(
//                 position,
//                 popularProductsStatic[0].products[position],
//               );
//             },
//           ),
//         ),
//         SizedBox(
//           height: Dimensions.height20,
//           child: DotsIndicator(
//             dotsCount: popularProductsStatic[0].products.length,
//             position: _currentPageValue.floor(),
//             decorator: DotsDecorator(
//               activeColor: AppColors.mainColor,
//               size: Size.square(Dimensions.height10),
//               activeSize: Size(Dimensions.height20, Dimensions.height10),
//               activeShape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(Dimensions.radius15),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildPageItem(int index, ProductModel popularProduct) {
//     Matrix4 matrix = Matrix4.identity();
//     if (index == _currentPageValue.floor()) {
//       var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else if (index == _currentPageValue.floor() + 1) {
//       var currScale =
//           _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else if (index == _currentPageValue.floor() - 1) {
//       var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
//       var currTrans = _height * (1 - currScale) / 2;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, currTrans, 0);
//     } else {
//       var currScale = 0.8;
//       matrix = Matrix4.diagonal3Values(1, currScale, 1)
//         ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
//     }
//
//     return Transform(
//       transform: matrix,
//       child: GestureDetector(
//         onTap: () {
//           Get.to(() => SalonDetailsView());
//         },
//         child: Stack(
//           children: [
//             Container(
//               height: Dimensions.pageViewContainer,
//               margin: EdgeInsets.only(
//                 left: Dimensions.width10,
//                 right: Dimensions.width10,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(Dimensions.radius30),
//                 color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
//                 image: DecorationImage(
//                   fit: BoxFit.cover,
//                   image: AssetImage(
//                     popularProduct.img!,
//                   ),
//                 ),
//               ),
//             ),
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 height: Dimensions.pageViewTextContainer,
//                 margin: EdgeInsets.only(
//                   left: Dimensions.width30,
//                   right: Dimensions.width30,
//                   bottom: Dimensions.height30,
//                 ),
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(Dimensions.radius20),
//                   color: Colors.white,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Color(0xFFe8e8e8),
//                       blurRadius: 5.0,
//                       offset: Offset(0, 5),
//                     ),
//                     BoxShadow(
//                       color: Colors.white,
//                       offset: Offset(-5, 0),
//                     ),
//                     BoxShadow(
//                       color: Colors.white,
//                       offset: Offset(5, 0),
//                     ),
//                   ],
//                 ),
//                 child: Container(
//                   padding: EdgeInsets.only(
//                     top: Dimensions.height15,
//                     left: Dimensions.width15,
//                     right: Dimensions.width15,
//                   ),
//                   child: ShowSalonCard(
//                     text: popularProduct.name!,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
