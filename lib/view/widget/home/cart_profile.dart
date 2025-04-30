import 'package:easycut/app.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/view/widget/main_circle_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/home/profile_controller.dart';

class CartProfile extends StatelessWidget {
  final String userName;
  final String userImage;
  final String userEmail;
  final void Function() logout;
  const CartProfile({
    super.key,
    required this.userName,
    required this.userImage,
    required this.userEmail,
    required this.logout,
  });

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProfileControllerImp());

    return GetBuilder<ProfileControllerImp>(builder: (controller) {
      return Card(
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.selectedColor,
            border: Border.all(color: AppColor.backgroundicons2, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    MainCircleImage(image: userImage),
                    Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                BigText(
                                  text: userName,
                                  size: 24,
                                ),
                                SizedBox(
                                  width: 190,
                                  child: Text(
                                    userEmail,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  // child: SmallText(
                                  //   text: userEmail,
                                  //   size: 16,
                                  // ),
                                ),
                              ],
                            ),
                            // GestureDetector(
                            //   onTap: (logout),
                            //   child: Image.asset(
                            //     'assets/images/icon/setting2.png',
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                            GestureDetector(
                              onTap: showProfileDialog,
                              child: Image.asset(
                                'assets/images/icon/setting2.png',
                                fit: BoxFit.cover,
                              ),
                            ),

                            // GestureDetector(
                            //   onTap: () {
                            //     Get.defaultDialog(
                            //       title: "Profile Actions",
                            //       content: Container(
                            //         height: 167,
                            //         width: 284,
                            //         decoration: BoxDecoration(
                            //           color: AppColor.backgroundButton,
                            //         ),
                            //         child: Column(
                            //           mainAxisSize: MainAxisSize.min,
                            //           children: [
                            //             ElevatedButton.icon(
                            //               iconAlignment: IconAlignment.end,
                            //               onPressed: () {
                            //                 Get.back();
                            //                 ProfileControllerImp().logout();
                            //               },
                            //               label: const Text("Logout",
                            //                   style: TextStyle(
                            //                       color: Colors.black)),
                            //               icon: const Icon(Icons.logout,
                            //                   color: AppColor.primaryColor),
                            //               style: ElevatedButton.styleFrom(
                            //                 backgroundColor:
                            //                     AppColor.backgroundButton,
                            //                 elevation: 1,
                            //                 side: const BorderSide(
                            //                   // Added border
                            //                   color: AppColor
                            //                       .backgroundicons2, // Hex color for the border
                            //                   width: 1, // 1px solid border
                            //                 ),
                            //                 shape: RoundedRectangleBorder(
                            //                   borderRadius: BorderRadius.circular(
                            //                       10), // Optional: Adjust corner radius
                            //                 ),
                            //               ),
                            //             ),
                            //             const SizedBox(height: 10),
                            //             TextButton(
                            //               onPressed: () {
                            //                 // Get.back();
                            //                 // ProfileControllerImp()
                            //                 //     .deleteAccount();
                            //               },
                            //               child: const Text(
                            //                 "Delete Account",
                            //                 style: TextStyle(
                            //                     color: Colors.red,
                            //                     fontWeight: FontWeight.bold),
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //     );
                            //   },
                            //   child: Image.asset(
                            //     'assets/images/icon/setting2.png',
                            //     fit: BoxFit.cover,
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  void showProfileDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Close Button
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close, color: Colors.red, size: 20),
                ),
              ),
              const SizedBox(height: 10),

              // Logout Button
              ElevatedButton.icon(
                iconAlignment: IconAlignment.end,
                onPressed: () {
                  Get.back();
                  ProfileControllerImp().logout();
                },
                icon: const ImageIcon(
                  AssetImage('assets/images/icon/logout.png'),
                  color: AppColor.primaryColor,
                ),
                label:
                    const Text("Logout", style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 2,
                  side: const BorderSide(
                    color: AppColor.backgroundButton, // Border color
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
              ),

              const SizedBox(height: 10),

              // Delete Account Button
              TextButton(
                onPressed: () {
                  Get.back();
                  ProfileControllerImp().deleteAccount();
                },
                child: const Text(
                  "Delete Account",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.primaryColor,
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierColor:
          AppColor.backgroundicons2.withOpacity(.7), // Black background overlay
      barrierDismissible: true, // Allows closing by tapping outside
    );
  }
}
