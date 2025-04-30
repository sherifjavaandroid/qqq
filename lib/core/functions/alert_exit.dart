import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<bool> alertExit() {
  Get.defaultDialog(
    title: "exitApp".tr,
    middleText: "Are you sure want to exit the app?".tr,
    actions: [
      ElevatedButton(
        onPressed: () {
          exit(0); // Exits the app
        },
        child: Text('yes'.tr),
      ),
      ElevatedButton(
        onPressed: () {
          Navigator.of(Get.context!).pop(); // Closes the dialog
        },
        child: Text('no'.tr),
      ),
    ],
  );
  return Future.value(false); // Returning false as the user chose "No"
}
