import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/localization/change_local.dart';
import 'package:easycut/core/localization/translation.dart';
import 'package:easycut/helper/binding.dart';
import 'package:easycut/view/screen/home/local_controller_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'routes.dart';

// Assuming LocalController, LocalControllerProfile, MyTranslation, MyBinding, and routes are defined elsewhere

class EasyCut extends StatelessWidget {
  const EasyCut({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Get.put to ensure LocalController is initialized
    final LocalController controller = Get.put(LocalController());

    // Ensure LocalControllerProfile is registered only once
    Get.lazyPut<LocalControllerProfile>(() => LocalControllerProfile());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark
          .copyWith(statusBarColor: AppColor.selectedColor // Your desired color
              ),
      child: ScreenUtilInit(
        designSize: const Size(440, 956),
        minTextAdapt: true,
        splitScreenMode: true,
        enableScaleWH: () => false,
        enableScaleText: () => false,
        child: GetMaterialApp(
          title: "Easy Cut",
          translations: MyTranslation(),
          // Safely set locale to avoid null check issues
          locale: controller.language ??
              Locale(Get.deviceLocale?.languageCode ??
                  'en'), // Default to 'en' if null
          debugShowCheckedModeBanner: false,
          theme: controller.appTheme,
          initialBinding: MyBinding(),
          // Define your routes
          getPages: routes,
        ),
      ),
    );
  }
}
