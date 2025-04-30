import 'package:easycut/app.dart';
import 'package:easycut/controller/home/home_screen_controller.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/image_asset.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenControllerImp());
    return Scaffold(
      backgroundColor: Colors.white,
      // body: _pages[controller.currentVal],
      body: GetBuilder<HomeScreenControllerImp>(
        builder: (controller) {
          return controller.pages[controller.currentPage];
        },
      ),
      bottomNavigationBar: GetBuilder<HomeScreenControllerImp>(
        builder: (controller) {
          return BottomNavigationBar(
            backgroundColor: AppColor.backgroundColor,
            currentIndex: controller.currentPage,
            type: BottomNavigationBarType.shifting,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(
                color:
                    AppColor.backgroundicons, // Keeps label color same for all
                fontSize: 14.sp,
                fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(
                color:
                    AppColor.backgroundicons, // Keeps label color same for all
                fontSize: 14.sp,
                fontWeight: FontWeight.w600),
            selectedItemColor:
                AppColor.backgroundicons, // Changes color of selected icon only
            unselectedItemColor: AppColor.backgroundicons,
            items: [
              BottomNavigationBarItem(
                icon: ImageIcon(
                  const AssetImage(AppImageAsset.home),
                  color: controller.currentPage == 0
                      ? AppColor.selectedColor // Changes selected icon color
                      : AppColor.backgroundicons, // Keeps others the same
                ),
                label: 'Home'.tr,
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.notifications_active),
              //   label: 'Notification',
              // ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  const AssetImage(AppImageAsset.booking),
                  color: controller.currentPage == 1
                      ? AppColor.selectedColor // Changes selected icon color
                      : AppColor.backgroundicons, // Keeps others the same
                ),
                label: 'Booking'.tr,
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  const AssetImage(AppImageAsset.bottomprofile),
                  color: controller.currentPage == 2
                      ? AppColor.selectedColor // Changes selected icon color
                      : AppColor.backgroundicons, // Keeps others the same
                ),
                label: 'Profile'.tr,
              ),
            ],
            onTap: (index) {
              controller.changePage(index);
            },
          );
        },
      ),
    );
  }
}
