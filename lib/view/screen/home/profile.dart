import 'package:easycut/controller/home/profile_controller.dart';
import 'package:easycut/core/class/handling_data_view.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/view/widget/home/cart_profile.dart';
import 'package:easycut/view/widget/profile/about_profile.dart';
import 'package:easycut/view/widget/profile/edit_profile_button.dart';
import 'package:easycut/view/widget/profile/location_settings.dart';
import 'package:easycut/view/widget/profile/profile_favorite_salons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:easycut/linkapi.dart';

import '../../../core/class/status_request.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a fresh controller instance
    final ProfileControllerImp controller = Get.put(ProfileControllerImp());

    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoute.home,
              (Route<dynamic> route) => false,
        );
        return false;
      },
      child: SafeArea(
        child: GetBuilder<ProfileControllerImp>(
          builder: (controller) {
            // Handle when data is still loading or when there's an error
            if (controller.statusRequest == StatusRequest.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            // Handle error state more gracefully
            if (controller.statusRequest == StatusRequest.serverFailure ||
                controller.statusRequest == StatusRequest.serverException) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 50, color: Colors.red),
                    SizedBox(height: 20),
                    Text(
                      "Failed to load profile data".tr,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => controller.getData(),
                      child: Text("Retry".tr),
                    )
                  ],
                ),
              );
            }

            // Use a fallback profile name if none is available
            final profileName = controller.profile.name ?? "Guest User".tr;
            final profileEmail = controller.profile.email ?? "guest@example.com";

            // Get profile image with fallback
            final String profileImage = controller.profile.image != null && controller.profile.image!.isNotEmpty
                ? '${AppLink.imageUsers}${controller.profile.image}'
                : "assets/images/icon/user.png";

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Card
                  CartProfile(
                    userName: profileName,
                    userImage: profileImage,
                    userEmail: profileEmail,
                    logout: () {
                      controller.logout();
                    },
                  ),

                  // Edit Profile Button
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: const EditProfileButton(),
                  ),
                  SizedBox(height: 10.h),

                  // Custom Tabs
                  Container(
                    width: double.infinity,
                    height: 41,
                    decoration: BoxDecoration(
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          color: AppColor.backgroundicons2,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.tabController?.animateTo(0),
                            child: Container(
                              alignment: Alignment.center,
                              height: 41,
                              decoration: BoxDecoration(
                                color: controller.selectedIndex == 0
                                    ? AppColor.selectedColor
                                    : Colors.white,
                              ),
                              child: Text(
                                "About".tr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => controller.tabController?.animateTo(1),
                            child: Container(
                              alignment: Alignment.center,
                              height: 41,
                              decoration: BoxDecoration(
                                color: controller.selectedIndex == 1
                                    ? AppColor.selectedColor
                                    : Colors.white,
                              ),
                              child: Text(
                                "Favorites".tr,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tab View Content
                  Expanded(
                    child: controller.tabController == null
                        ? Center(child: Text("Loading tabs...".tr))
                        : TabBarView(
                      controller: controller.tabController,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AboutProfile(
                                email: controller.profile.email ?? "",
                                country: controller.profile.country ?? "",
                                gender: controller.profile.gender,
                                city: controller.profile.city,
                                address: controller.profile.address,
                                phone: controller.profile.phone,
                              ),
                              SizedBox(height: 20.h),
                              // Location Settings
                              const LocationSettings(),
                            ],
                          ),
                        ),
                        controller.favorites.isEmpty
                            ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.favorite_border, size: 48, color: Colors.grey),
                              SizedBox(height: 16),
                              Text("No favorites yet".tr, style: TextStyle(fontSize: 18))
                            ],
                          ),
                        )
                            : ProfileFavoriteSalons(
                          favorites: controller.favorites,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}