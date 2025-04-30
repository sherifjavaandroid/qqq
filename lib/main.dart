import 'package:easycut/controller/home/booking_screen_controller.dart';
import 'package:easycut/controller/home/salon_rates_controller.dart';
import 'package:easycut/core/class/crud.dart';
import 'package:easycut/core/services/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'app.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// Future<void> requestNotificationPermissions() async {
//   var status = await Permission.notification.status;

//   // Request permission if not granted
//   if (!status.isGranted) {
//     status = await Permission.notification.request();
//     if (!status.isGranted) {}
//   }
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request notification permissions before initializing Firebase
  // await requestNotificationPermissions();

  // Initialize Firebase
  await Firebase.initializeApp();

  // Initialize Notification Plugin
  // const initializationSettings = InitializationSettings(
  //   android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  // );

  // Initialize the flutterLocalNotificationsPlugin
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Time zone initialization
  tz.initializeTimeZones();

  await initialServices();
  await ScreenUtil.ensureScreenSize();

  // Dependency injections
  Get.put(Crud());
  Get.put(BookingScreenControllerImp());
  Get.put(SalonRatesController()); // Ensures the controller is available

  runApp(const EasyCut());
}
