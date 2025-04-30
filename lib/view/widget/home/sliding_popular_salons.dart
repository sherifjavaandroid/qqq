import 'package:dots_indicator/dots_indicator.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/data/model/salon_model.dart';
import 'package:easycut/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'show_salon_card.dart';

class SlidingPopularSalons extends StatefulWidget {
  final List<SalonModel> popularSalon;
  const SlidingPopularSalons({
    super.key,
    required this.popularSalon,
  });

  @override
  State<SlidingPopularSalons> createState() => _SlidingPopularSalonsState();
}

class _SlidingPopularSalonsState extends State<SlidingPopularSalons> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currentPageValue = 0.0;
  final _scaleFactor = 0.8;
  final _height = Dimensions.pageViewContainer;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Featured Salons Header
        Padding(
          padding: EdgeInsets.only(
            left: 38.w,
            right: 38.w,
            bottom: 10.h,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Featured Icon
              Container(
                padding: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: AppColor.selectedColor,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 16.sp,
                ),
              ),
              SizedBox(width: 8.w),
              // Featured Text
              BigText(
                text: "Featured Salons".tr,
                color: AppColor.primaryColor,
                size: 20.sp,
              ),
            ],
          ),
        ),

        // Small description text
        Padding(
          padding: EdgeInsets.only(
            left: 38.w,
            right: 38.w,
            bottom: 10.h,
          ),
          child: Align(
            alignment: Alignment.centerLeft,
            child: SmallText(
              text: "Top rated and promoted salons".tr,
              color: AppColor.grey,
              size: 14.sp,
            ),
          ),
        ),

        // Slider for Popular Salons
        SizedBox(
          height: Dimensions.pageView,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.popularSalon.length,
            itemBuilder: (context, position) {
              return _buildPageItem(
                position,
                widget.popularSalon[position],
              );
            },
          ),
        ),

        // Dots Indicator
        SizedBox(
          height: Dimensions.height20,
          child: DotsIndicator(
            dotsCount: widget.popularSalon.isEmpty ? 1 : widget.popularSalon.length,
            position: _currentPageValue.floor(),
            decorator: DotsDecorator(
              activeColor: AppColor.primaryColor,
              size: Size.square(Dimensions.height10),
              activeSize: Size(Dimensions.height20, Dimensions.height10),
              activeShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimensions.radius15),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageItem(int index, SalonModel salon) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _scaleFactor) / 2, 1);
    }

    return Transform(
      transform: matrix,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(AppRoute.salonDetails, arguments: {
            "salonid": salon.id,
          });
        },
        child: Stack(
          children: [
            // Main Container
            Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                left: Dimensions.width10,
                right: Dimensions.width10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven
                    ? const Color(0xFF69c5df)
                    : const Color(0xFF9294cc),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "${AppLink.imageSalons}${salon.image}",
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),

            // Featured badge
            Positioned(
              top: 10.h,
              right: 20.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "Featured".tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Classification badge
            if (salon.classification != null)
              Positioned(
                top: 20.h,
                left: 20.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: salon.classification == 'luxury'
                        ? const Color(0xFFD4AF37).withOpacity(0.9) // Gold for luxury
                        : const Color(0xFF4CAF50).withOpacity(0.9), // Green for economic
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    salon.classification == 'luxury' ? 'Luxury'.tr : 'Economic'.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),

            // Salon Information Card
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: EdgeInsets.only(
                  left: Dimensions.width30,
                  right: Dimensions.width30,
                  bottom: Dimensions.height30,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(5, 0),
                    ),
                  ],
                ),
                child: Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height15,
                    left: Dimensions.width15,
                    right: Dimensions.width15,
                  ),
                  child: ShowSalonCard(
                    text: salon.name!,
                    gender: salon.categoryId.toString(),
                    phone: salon.phone.toString(),
                    rate: salon.rate!.toString(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}