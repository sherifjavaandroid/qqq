import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/data/model/favorite_model.dart';
import 'package:easycut/linkapi.dart';
import 'package:easycut/view/widget/home/icon_and_text.dart';
import 'package:easycut/view/widget/home/salon_rate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// class ProfileFavoriteSalons extends StatelessWidget {
//   final List<FavoriteModel>? favorites;
//   const ProfileFavoriteSalons({
//     super.key,
//     this.favorites,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeControllerImp>(builder: (controller) {
//       // Check if favorites is null or empty
//       if (favorites == null || favorites!.isEmpty) {
//         return const Center(
//           child: Text("No favorite salons yet."),
//         );
//       }

//       return ListView.builder(
//         shrinkWrap: true, // Allows the list to take the required height
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: favorites!.length,
//         itemBuilder: (context, index) {
//           // Ensure index is within the valid range of newSalons
//           if (index >= controller.newSalons.length) {
//             return const SizedBox(); // Avoid accessing an invalid index
//           }

//           return NewestSalonItem(
//             salon: controller.newSalons[index],
//           );
//         },
//       );
//     });
//   }
// }
class ProfileFavoriteSalons extends StatelessWidget {
  final List<FavoriteModel> favorites;
  const ProfileFavoriteSalons({
    super.key,
    required this.favorites,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.height20,
      ),
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final salon = favorites[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 5),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(AppRoute.salonDetails, arguments: {
                "salonid": salon.id,
              });
            },
            child: Container(
              width: 364.w,
              height: 201.h,
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColor.backgroundicons2, width: 1),
                color: AppColor.backgroundButton,
              ),
              child: Column(
                children: [
                  Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Container(
                        width: 344.w,
                        height: 126.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.r),
                          border: Border.all(
                              color: const Color(0xffA3A5A7), width: 1.5.w),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "${AppLink.imageSalons}${salon.image}",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: FittedBox(
                            child: SalonRatingWidget(salonId: salon.id!),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 135.w),
                          child: BigText(
                            maxLines: 1,
                            text: salon.name!,
                            color: AppColor.backgroundicons,
                            size: 18.sp,
                          ),
                        ),
                        IconAndTextWidget(
                          icon: 'assets/images/icon/call-calling.png',
                          text: salon.phone!,
                          iconColor: AppColor.primaryColor,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/icon/location.png',
                            height: 25.h,
                            width: 25.w,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 160.w),
                              child: SmallText(
                                height: 1,
                                fontFamily: 'Cairo',
                                maxline: 2,
                                overFlow: TextOverflow.ellipsis,
                                text:
                                    "${salon.city} | ${salon.address}".trArgs(),
                                color: Colors.black,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      IconAndTextWidget(
                        icon: salon.categoryId == 1
                            ? "assets/images/icon/man.png"
                            : "assets/images/icon/woman.png",
                        text: salon.categoryId == 1 ? "Men".tr : "Women".tr,
                        iconColor: AppColor.grey,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
