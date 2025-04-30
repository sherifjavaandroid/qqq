import 'package:easycut/core/constant/app_theme.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalController extends GetxController {
  Locale? language;
  MyServices myServices = Get.find();

  ThemeData appTheme = themeEnglish;

  void changeLang(String langCode) {
    Locale locale = Locale(langCode);
    myServices.sharedPreferences
        .setString('lang', langCode); // Use null-aware operator
    appTheme = langCode == 'en' ? themeEnglish : themeArabic;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
    Get.offNamed(AppRoute.onBoarding);
  }

  @override
  void onInit() {
    super.onInit(); // Call super first

    // Check if sharedPreferences is not null before accessing it
    String? sharedPrefLang = myServices.sharedPreferences.getString('lang');

    if (sharedPrefLang == 'ar') {
      language = const Locale('ar');
      appTheme = themeArabic;
    } else if (sharedPrefLang == 'de') {
      language = const Locale('de');
      appTheme = themeEnglish;
    } else if (sharedPrefLang == 'en') {
      language = const Locale('en');
      appTheme = themeEnglish;
    } else {
      // Default to the device locale or fallback to 'en'
      language = Get.deviceLocale != null
          ? Locale(Get.deviceLocale!.languageCode)
          : const Locale('en');
      appTheme = themeEnglish; // Set default theme
    }
  }
}
