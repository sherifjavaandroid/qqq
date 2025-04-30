import 'package:easycut/view/screen/home/local_controller_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      alignment: Alignment.bottomLeft,
      underline: const SizedBox(),
      // Removes the underline

      icon: Padding(
        padding: const EdgeInsets.only(left: 200),
        child: const Icon(Icons.arrow_drop_down, size: 30),
      ), // Custom arrow icon

      value: Get.locale?.languageCode, // Get the current language code
      items: [
        DropdownMenuItem(
          value: 'ar',
          child: Text('Arabic'.tr),
        ),
        DropdownMenuItem(
          value: 'en',
          child: Text('English'.tr),
        ),
        DropdownMenuItem(
          value: 'de',
          child: Text('German'.tr),
        ),
      ],
      onChanged: (String? newValue) {
        if (newValue != null) {
          Get.lazyPut(() => LocalControllerProfile());
          // Change language and refresh UI
          Get.find<LocalControllerProfile>().changeLang(newValue);
        }
      },
    );
  }
}
