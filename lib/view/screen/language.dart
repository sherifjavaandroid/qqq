import 'package:easycut/core/localization/change_local.dart';
import 'package:easycut/core/shared/widgets/big_text.dart';
import 'package:easycut/view/widget/language/custom_button_lang.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Language extends GetView<LocalController> {
  const Language({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
                height: 280.h,
                width: 280.w,
                child: Image.asset('assets/images/icon/logo.png')),
            SizedBox(
              height: 60.h,
              child: BigText(
                text: 'chooseLanguage'.tr,
                size: 32.sp,
              ),
            ),
            SizedBox(
              height: 60.h,
            ),
            CustomButtonLang(
              textButton: 'arabic'.tr,
              onPressed: () {
                controller.changeLang('ar');
              },
            ),
            CustomButtonLang(
              textButton: 'english'.tr,
              onPressed: () {
                controller.changeLang('en');
              },
            ),
            CustomButtonLang(
              textButton: 'german'.tr,
              onPressed: () {
                controller.changeLang('de');
              },
            ),
          ],
        ),
      ),
    );
  }
}
