import 'package:easycut/core/constant/color.dart';
import 'package:easycut/linkapi.dart';
import 'package:easycut/view/widget/salon_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StackImageDetail extends StatelessWidget {
  final String salonImage;
  final int salonId;
  final String salonName;

  const StackImageDetail({
    super.key,
    required this.salonImage,
    required this.salonId,
    required this.salonName,
  });

  @override
  Widget build(BuildContext context) {
    // Debug print to confirm the widget is being rendered with the correct parameters
    debugPrint('Building StackImageDetail for salon: $salonName, id: $salonId, image: $salonImage');

    return Positioned(
      left: 0,
      right: 0,
      top: 29.h,
      child: Stack(
        children: [
          // Salon Image
          SizedBox(
            width: double.infinity,
            height: 328.h,
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 14.h,
              ),
              child: Image.network(
                "${AppLink.imageSalons}$salonImage",
                fit: BoxFit.fill,
              ),
            ),
          ),

          // Share and QR buttons - positioned at bottom right
          Positioned(
            right: 15.w,
            bottom: 25.h,
            // Add a debug container to ensure position is correct
            child: Container(
              // Add a debug border to make it visible
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 2),
              ),
              child: SalonShareWidget(
                salonId: salonId,
                salonName: salonName,
              ),
            ),
          ),

          // Add an additional testing widget to ensure positioning works
          Positioned(
            left: 15.w,
            bottom: 25.h,
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text('TEST', style: TextStyle(color: Colors.white, fontSize: 10.sp)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}