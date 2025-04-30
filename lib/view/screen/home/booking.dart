import 'package:easycut/controller/home/booking_screen_controller.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/services/services.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/linkapi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/class/handling_data_view.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BookingViewState createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> with WidgetsBindingObserver {
  late BookingScreenControllerImp controller;
  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  final Map<String, int?> _previousStatuses = {};
  MyServices myServices = Get.find();

  @override
  void initState() {
    super.initState();
    controller = Get.find<BookingScreenControllerImp>();
    WidgetsBinding.instance.addObserver(this);

    _setupRealTimeUpdates();
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   // Dispose of any listeners or streams related to the controller.
  //   controller.dispose();
  //   super.dispose();
  // }

  void _setupRealTimeUpdates() {
    // Retrieve userId from shared preferences
    // String? userId = MyServices.sharedPreferences!.getString('userId'); // Make sure MyServices is correctly defined
    dynamic? userId = myServices.sharedPreferences!.getInt('id');
    if (kDebugMode) {
      print(userId);
    }
    // Check if userId is not null or empty before fetching bookings

    controller.fetchBookingsFromApi();

    if (kDebugMode) {
      print('User ID is not available.');
    }
  }

  bool _hasFetchedData = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !_hasFetchedData) {
      _hasFetchedData = true;
      controller.update();
    }
  }

  // Define the notification function
  Future<void> _sendNotification(String approveStatus) async {
    String title = "Booking Status Update";
    String body;

    // Determine the notification message based on the approval status
    switch (approveStatus) {
      case '1':
        body = "Congratulations! Your booking has been accepted by the admin.";
        break;
      case '2':
        body = "We're sorry, but your booking was refused by the admin.";
        break;
      default:
        body = "Your booking status has been updated.";
    }

    // Create Android notification details
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'booking_channel', // Channel ID
      'Booking Status', // Channel Name
      channelDescription: 'Shows updates for booking status',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      color: Color(0xFF123456),
      styleInformation: BigTextStyleInformation(''),
      enableLights: true,
      enableVibration: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    // Show the notification
    await flutterLocalNotificationsPlugin?.show(
      0, // Notification ID (can be unique for each notification)
      title, // Notification title
      body, // Notification body
      platformChannelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        // Prevent stack duplication by pushing only one instance of the home screen.
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoute.home,
              (Route<dynamic> route) => false,
        );
        return false;
      },
      child: SafeArea(
        child: Obx(() {
          return HandlingDataView(
            statusRequest: controller.statusRequest.value,
            widget: Padding(
              padding: EdgeInsets.symmetric(horizontal: Dimensions.width10.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 45.h,
                    width: double.infinity.w,
                    child: Center(
                      child: SmallText(
                        text: "All Bookings".tr,
                        size: 24.sp,
                      ),
                    ),
                  ),
                  Expanded(
                    child: controller.bookings.isEmpty
                        ? Center(
                      child: BigText(
                        // Check if the user is in guest mode
                        text: myServices.sharedPreferences.getInt('id') ==
                            null
                            ? "Please login to make a booking."
                            .tr // Guest mode prompt
                            : "No bookings available"
                            .tr, // Standard message for logged-in users with no bookings
                        color: AppColor.primaryColor,
                      ),
                    )
                        : ListView.separated(
                      itemBuilder: (context, index) {
                        final booking = controller.bookings[index];

                        return SizedBox(
                          height: 325.h, // Increased height to accommodate action buttons
                          width: 294.w,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 5,
                              // shadowColor: Colors.grey.withOpacity(0.3),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 126.h,
                                    width: 344.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(
                                              Dimensions.radius5)),
                                      child: booking.image != null
                                          ? Image.network(
                                        "${AppLink.imageSalons}${booking.image}",
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context,
                                            child,
                                            loadingProgress) {
                                          if (loadingProgress ==
                                              null) {
                                            return child;
                                          }
                                          return const Center(
                                            child:
                                            CircularProgressIndicator(),
                                          );
                                        },
                                        errorBuilder: (context,
                                            error, stackTrace) {
                                          return const Center(
                                            child: Icon(
                                              Icons
                                                  .image_not_supported,
                                              size: 50,
                                              color: Colors.grey,
                                            ),
                                          );
                                        },
                                      )
                                          : Center(
                                        child: Image.network(
                                          'https://th.bing.com/th/id/OIP.U0QLQk1bHABNJk1_J6BCKwAAAA?rs=1&pid=ImgDetMain',
                                          errorBuilder: (context,
                                              error, stackTrace) {
                                            return Text(
                                              'Please check your internet connection'
                                                  .tr,
                                              style: const TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 16,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimensions.width10.w),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 34.h,
                                          width: 344.w,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              ConstrainedBox(
                                                constraints:
                                                BoxConstraints(
                                                    maxWidth: 200.w),
                                                child: BigText(
                                                    text: booking
                                                        .salonname!),
                                              ),
                                              _buildStatusIndicator(
                                                booking.approve,
                                                imagePath:
                                                'assets/images/icon/lock.png',
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30.h,
                                          width: 344.w,
                                          child: _buildInfoRow(
                                            "".tr,
                                            booking.phone ?? 'N/A',
                                            'assets/images/icon/call-calling.png',
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30.h,
                                          width: 344.w,
                                          child: Row(
                                            children: [
                                              _buildInfoRow(
                                                "".tr,
                                                booking.day ?? 'N/A',
                                                'assets/images/icon/calendar.png',
                                              ),
                                              SizedBox(
                                                  width: Dimensions
                                                      .width10.w),
                                              _buildInfoRow(
                                                "".tr,
                                                booking.time ?? 'N/A',
                                                'assets/images/icon/clock.png',
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(
                                              height: 30.h,
                                              child: _buildInfoRow(
                                                "".tr,
                                                "${booking.total ?? '0'} \$",
                                                'assets/images/icon/dollar-square.png',
                                              ),
                                            ),
                                          ],
                                        ),

                                        // Action Buttons - New addition
                                        SizedBox(height: 10.h),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            // Cancel Button
                                            _buildActionButton(
                                              text: "Cancel".tr,
                                              icon: Icons.cancel_outlined,
                                              color: Colors.red,
                                              onPressed: () {
                                                // Check if booking is in the waiting or approved state
                                                if (booking.approve == "0" || booking.approve == "1") {
                                                  int bookingId = int.tryParse(booking.id.toString()) ?? 0;
                                                  if (bookingId > 0) {
                                                    Get.toNamed(AppRoute.bookingCancellation, arguments: {
                                                      'bookingId': bookingId,
                                                      'day': booking.day ?? '',
                                                      'time': booking.time ?? '',
                                                      'salonName': booking.salonname ?? '',
                                                    });
                                                  }
                                                } else {
                                                  Get.snackbar(
                                                      'Cannot Cancel'.tr,
                                                      'This booking cannot be cancelled'.tr,
                                                      snackPosition: SnackPosition.BOTTOM
                                                  );
                                                }
                                              },
                                            ),

                                            // Reschedule Button
                                            _buildActionButton(
                                              text: "Reschedule".tr,
                                              icon: Icons.schedule,
                                              color: AppColor.primaryColor,
                                              onPressed: () {
                                                // Check if booking is in the waiting or approved state
                                                if (booking.approve == "0" || booking.approve == "1") {
                                                  int bookingId = int.tryParse(booking.id.toString()) ?? 0;
                                                  int salonId = int.tryParse(booking.salonid?.toString() ?? "0") ?? 0;

                                                  if (bookingId > 0 && salonId > 0) {
                                                    Get.toNamed(AppRoute.rescheduleBooking, arguments: {
                                                      'bookingId': bookingId,
                                                      'salonId': salonId,
                                                    });
                                                  } else {
                                                    Get.snackbar(
                                                        'Error'.tr,
                                                        'Missing required information for rescheduling'.tr,
                                                        snackPosition: SnackPosition.BOTTOM
                                                    );
                                                  }
                                                } else {
                                                  Get.snackbar(
                                                      'Cannot Reschedule'.tr,
                                                      'This booking cannot be rescheduled'.tr,
                                                      snackPosition: SnackPosition.BOTTOM
                                                  );
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 5.h);
                      },
                      itemCount: controller.bookings.length,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildInfoRow(String? label, String? value, String? icon) {
    return Row(
      children: [
        if (icon != null) ...[
          ImageIcon(
            AssetImage(icon),
          ),
          SizedBox(width: Dimensions.width5.w),
        ],
        SmallText(
          text: label ?? '',
          size: Dimensions.font16.sp,
        ),
        SmallText(
          text: value ?? '',
          size: 16.sp,
          color: AppColor.backgroundicons,
        ),
      ],
    );
  }

  // Build a status indicator
  Widget _buildStatusIndicator(String? approve, {String? imagePath}) {
    final status = int.tryParse(approve ?? '0') ?? 0; // Default to 0 (Waiting)

    // Check the previous status, default to 0 (Waiting)
    final previousStatus = _previousStatuses[approve] ?? 0;

    // Notify if status changes from 0 (Waiting) to 1 (Accepted) or 2 (Refused)
    if (previousStatus == 0 && status != 0) {
      if (status == 1) {
        _sendNotification('1'); // Booking accepted
      } else if (status == 2) {
        _sendNotification('2'); // Booking refused
      }
      _previousStatuses[approve!] = status; // Update previous status
    }

    // Determine status text and color
    String statusText;
    Color statusColor;

    switch (status) {
      case 1:
        statusText = "Accepted".tr;
        statusColor = Colors.green;
        break;
      case 2:
        statusText = "Refused".tr;
        statusColor = Colors.red;
        break;
      default:
        statusText = "Waiting".tr;
        statusColor = Colors.orange;
    }

    return _buildStatus(statusText, statusColor, imagePath);
  }

  Widget _buildStatus(String status, Color color, String? imagePath) {
    return Container(
      decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (imagePath != null)
            Padding(
              padding: const EdgeInsets.only(right: 10.0, left: 10),
              child: Image.asset(
                imagePath,
                width: 18,
                height: 18,
                color: color,
              ),
            ),
          Text(
            status,
            style: TextStyle(
                color: color, fontWeight: FontWeight.w500, fontSize: 14.sp),
          ),
        ],
      ),
    );
  }

  // New method to build action buttons
  Widget _buildActionButton({
    required String text,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white, size: 18.sp),
      label: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 12.sp),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}