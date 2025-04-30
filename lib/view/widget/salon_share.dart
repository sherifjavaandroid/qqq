import 'package:easycut/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../helper/qrcode_helper.dart';

class SalonShareWidget extends StatelessWidget {
  final int salonId;
  final String salonName;

  const SalonShareWidget({
    Key? key,
    required this.salonId,
    required this.salonName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Debug print to confirm the widget is being rendered
    debugPrint('Building SalonShareWidget for salon: $salonName, id: $salonId');

    return Container(
      // Add a debug border to make it visible
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // QR Code button
          GestureDetector(
            onTap: () {
              debugPrint('QR Code button tapped for salon: $salonName');
              QRCodeHelper.showQRCodeDialog(context, salonId, salonName);
            },
            child: Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: AppColor.unselectedservies,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColor.backgroundicons,
                  width: 1.5.w,
                ),
              ),
              child: const Icon(
                Icons.qr_code,
                color: AppColor.backgroundicons,
              ),
            ),
          ),
          SizedBox(width: 10.w),
          // Share button
          GestureDetector(
            onTap: () {
              debugPrint('Share button tapped for salon: $salonName');
              QRCodeHelper.shareSalon(context, salonId, salonName);
            },
            child: Container(
              width: 36.w,
              height: 36.h,
              decoration: BoxDecoration(
                color: AppColor.unselectedservies,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: AppColor.backgroundicons,
                  width: 1.5.w,
                ),
              ),
              child: const Icon(
                Icons.share,
                color: AppColor.backgroundicons,
              ),
            ),
          ),
        ],
      ),
    );
  }
}