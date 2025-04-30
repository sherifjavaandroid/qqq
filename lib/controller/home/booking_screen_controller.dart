// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:easycut/linkapi.dart';
import 'package:easycut/view/screen/home/notification.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:easycut/core/class/status_request.dart';
import 'package:easycut/core/services/services.dart';
import 'package:easycut/data/model/booking_model.dart';
import 'package:easycut/view/widget/home/header_main_view.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class BookingScreenControllerImp extends GetxController {
  RxList<BookingModel> bookings = <BookingModel>[].obs;
  Rx<StatusRequest> statusRequest = StatusRequest.failure.obs;
  HeaderMainView? headerMainView;
  MyServices myServices = Get.find();
  StreamSubscription? _bookingSubscription;
  final Map<String, int> _previousApprovalStatuses = {};
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Timer? _refreshTimer; // Add a Timer for automatic refresh

  @override
  void onInit() {
    super.onInit();
    _initializeHeader();
    _initializeLocalNotifications();
    fetchBookingsFromApi();
  }

  void _initializeHeader() {
    String userName = myServices.sharedPreferences.getString('name') ?? '';
    headerMainView = HeaderMainView(name: userName);
  }

  void _initializeLocalNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> fetchBookingsFromApi() async {
    String userId = myServices.sharedPreferences.getString('userId') ?? '';
    if (userId.isEmpty) return;

    try {
      final response = await http.get(
        Uri.parse('${AppLink.viewBookings}?userid=$userId'),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData.containsKey('data')) {
          List<dynamic> bookingData = responseData['data'];
          bookings.clear();

          for (var data in bookingData) {
            BookingModel booking = BookingModel.fromJson(data);
            bookings.add(booking);
          }

          statusRequest.value =
              bookings.isEmpty ? StatusRequest.failure : StatusRequest.success;
        } else {
          if (kDebugMode) {
            print('The key "data" does not contain bookings.');
          }
          statusRequest.value = StatusRequest.loading;
        }
      } else {
        if (kDebugMode) {
          print('Failed to fetch bookings: ${response.statusCode}');
        }
        statusRequest.value = StatusRequest.failure;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching bookings: $e');
      }
      statusRequest.value = StatusRequest.failure;
    }
  }

  final NotificationService notificationService = NotificationService();

  // ignore: unused_element
  void _notifyIfStatusChanged(Map<String, dynamic> data, [String? oldStatus]) {
    final String bookingId = data['id'].toString();
    final int newStatus = int.tryParse(data['approve'].toString()) ?? 0;

    final int previousStatus = _previousApprovalStatuses[bookingId] ?? -1;

    if (newStatus != previousStatus) {
      _previousApprovalStatuses[bookingId] = newStatus;

      if (newStatus == 1) {
        _sendAcceptedNotification();
      } else if (newStatus == 2) {
        _sendRefusedNotification();
      }
    } else {
      if (kDebugMode) {
        print("No status change detected for booking ID $bookingId.");
      }
    }
  }

  Future<void> _sendAcceptedNotification() async {
    await notificationService.showNotification(
      'Booking Approved'.tr,
      'Your booking has been approved!'.tr,
      channelId: 'booking_channel',
      channelName: 'Booking Notifications',
    );
  }

  Future<void> _sendRefusedNotification() async {
    await notificationService.showNotification(
      'Booking Refused'.tr,
      'Your booking has been refused.'.tr,
      channelId: 'booking_channel',
      channelName: 'Booking Notifications',
    );
  }

  @override
  void onClose() {
    _bookingSubscription?.cancel();
    _refreshTimer?.cancel(); // Cancel the timer when the controller is closed
    if (kDebugMode) {
      print("BookingScreenControllerImp disposed");
    }
    super.onClose();
  }
}
