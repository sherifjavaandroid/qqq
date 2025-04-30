import 'package:easycut/view/screen/home/booking.dart';
import 'package:easycut/view/screen/home/main.dart';
import 'package:easycut/view/screen/home/profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class HomeScreenController extends GetxController {
  changePage(int val);
}

class HomeScreenControllerImp extends HomeScreenController {
  int currentPage = 0;

  List<Widget> pages = [
    const MainView(),
    const BookingView(),
    const ProfileView(),
  ];

  @override
  changePage(int val) {
    currentPage = val;
    update();
  }
}
