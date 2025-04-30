import 'package:easycut/controller/home/home_controller.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/location_services.dart';

class LocationIndicator extends StatelessWidget {
  const LocationIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocationServices locationServices = Get.find<LocationServices>();
    final HomeControllerImp homeController = Get.find<HomeControllerImp>();

    return Obx(() {
      if (!homeController.isLocationEnabled.value) {
        return _buildDisabledWidget(context);
      }

      if (locationServices.isLoading.value) {
        return _buildLoadingWidget();
      }

      return _buildLocationInfoWidget(locationServices);
    });
  }

  Widget _buildDisabledWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showEnableLocationDialog(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        margin: EdgeInsets.symmetric(horizontal: 38.w),
        decoration: BoxDecoration(
            color: AppColor.backgroundButton,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: AppColor.backgroundicons2)
        ),
        child: Row(
          children: [
            Icon(Icons.location_off, size: 20.sp, color: Colors.grey),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Enable location to see nearby salons'.tr,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      margin: EdgeInsets.symmetric(horizontal: 38.w),
      decoration: BoxDecoration(
          color: AppColor.backgroundButton,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColor.backgroundicons2)
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
            height: 20.h,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.selectedColor),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            'Getting your location...'.tr,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationInfoWidget(LocationServices locationServices) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      margin: EdgeInsets.symmetric(horizontal: 38.w),
      decoration: BoxDecoration(
          color: AppColor.backgroundButton,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(color: AppColor.backgroundicons2)
      ),
      child: Row(
        children: [
          Icon(Icons.location_on, size: 20.sp, color: AppColor.selectedColor),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              locationServices.city.value.isNotEmpty
                  ? '${locationServices.city.value}, ${locationServices.country.value}'
                  : 'Location found'.tr,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _showEnableLocationDialog(BuildContext context) {
    final LocationServices locationServices = Get.find<LocationServices>();
    final HomeControllerImp homeController = Get.find<HomeControllerImp>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enable Location'.tr),
          content: Text('Enable location services to see nearby salons and get better recommendations'.tr),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Enable'.tr),
              onPressed: () async {
                Navigator.of(context).pop();
                await locationServices.checkLocationPermission();
                if (locationServices.hasPermission.value) {
                  homeController.isLocationEnabled.value = true;
                  await homeController.refreshSalonsWithLocation();
                }
              },
            ),
          ],
        );
      },
    );
  }
}