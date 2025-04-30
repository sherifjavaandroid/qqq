// import 'package:easycut/core/utils/colors.dart';
// import 'package:easycut/core/utils/dimensions.dart';
// import 'package:easycut/core/view_model/home_view_model.dart';
// import 'package:easycut/features/home/booking/booking_view.dart';
// import 'package:easycut/features/home/main/main_view.dart';
// import 'package:easycut/features/home/notification/notification_view.dart';
// import 'package:easycut/features/home/profile/profile_view.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class HomeView extends GetWidget<HomeViewModel> {
//   HomeView({super.key});
//
//   final List<Widget> _pages = [
//     MainView(),
//     NotificationView(),
//     BookingView(),
//     ProfileView(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<HomeViewModel>(
//       builder: (ctrl) => Scaffold(
//         backgroundColor: Colors.white,
//         body: _pages[controller.currentVal],
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(Dimensions.radius15),
//             color: Colors.red,
//           ),
//           child: BottomNavigationBar(
//             currentIndex: controller.currentVal,
//             type: BottomNavigationBarType.shifting,
//             showSelectedLabels: true,
//             showUnselectedLabels: false,
//             selectedItemColor: AppColors.mainColor,
//             unselectedItemColor: Colors.grey[400],
//             items: const [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.notification_important),
//                 label: 'Notification',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.calendar_month),
//                 label: 'Booking',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 label: 'Profile',
//               ),
//             ],
//             onTap: (index) {
//               controller.changeCurrentVal(index);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
