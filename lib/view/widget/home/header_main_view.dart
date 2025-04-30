// Make sure to import the color constants
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/data/model/salon_model.dart';
import 'package:easycut/linkapi.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderMainView extends StatefulWidget {
  final String? image;
  final String? name;

  const HeaderMainView({
    super.key,
    required this.name,
    this.image,
  });

  @override
  State<HeaderMainView> createState() => _HeaderMainViewState();
}

class _HeaderMainViewState extends State<HeaderMainView> {
  bool isSearching = false;
  final searchTextController = TextEditingController();
  late List<SalonModel> searchedForCharacters;
  late List<SalonModel> allCharacters;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 60.h,
          width: 60
              .w, // Ensure the container has a width to maintain circular shape
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(58.r),
            child: Image.network(
              widget.image != null
                  ? "${AppLink.imageUsers}${widget.image}"
                  : 'https://img.freepik.com/premium-photo/handsome-male-model-man-smiling-with-perfectly-clean-teeth-stock-photo-dental-background_592138-1188.jpg?w=2000',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                    child: Image.network(
                  'https://img.freepik.com/premium-photo/handsome-male-model-man-smiling-with-perfectly-clean-teeth-stock-photo-dental-background_592138-1188.jpg?w=2000',
                ));
              },
            ),
          ),
        ),
        SizedBox(width: Dimensions.width10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SmallText(
              text: "Hello".tr,
              color: AppColor.textColor,
              size: Dimensions.font16.sp,
            ),
            BigText(
              text: widget.name ?? '',
              color: AppColor.titleColor,
              size: 24.sp,
            ),
          ],
        ),
        // const Spacer(),
        // Center(
        //   child: Container(
        //     width: Dimensions.width45.w,
        //     height: Dimensions.height45.h,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(
        //         Dimensions.radius15,
        //       ),
        //       color: const Color.fromARGB(255, 248, 248, 248),
        //     ),
        //     // child: IconButton(
        //     //   icon: Icon(
        //     //     Icons.search,
        //     //     color: const Color.fromARGB(255, 1, 1, 1),
        //     //     size: Dimensions.iconSize24,
        //     //   ),
        //     //   onPressed: () {
        //     //     showSearch(context: context, delegate: SalonSearchDelegate());
        //     //   },
        //     // ),
        //   ),
        // ),
      ],
    );
  }
}
