import 'package:easycut/core/constant/app_theme.dart';
import 'package:easycut/core/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalControllerProfile extends GetxController {
  Locale? language;
  MyServices myServices = Get.find();

  ThemeData appTheme = themeEnglish;

  changeLang(String langCode) {
    Locale locale = Locale(langCode);
    myServices.sharedPreferences.setString('lang', langCode);
    appTheme = langCode == 'en' ? themeEnglish : themeArabic;
    Get.changeTheme(appTheme);
    Get.updateLocale(locale);
    Get.lazyPut(() => LocalControllerProfile());
    //Get.offNamed(AppRoute.onBoarding);
  }

  @override
  void onInit() {
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
      language = Locale(Get.deviceLocale!.languageCode);
      appTheme = themeEnglish;
    }
    super.onInit();
  }
}
