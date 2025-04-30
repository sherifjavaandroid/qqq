import 'package:easycut/app.dart';
import 'package:easycut/controller/auth/verify_code_controller.dart';
import 'package:easycut/core/class/handling_data_view.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/view/widget/auth/header_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyCode extends StatelessWidget {
  const VerifyCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 36.h,
            width: 36.w,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF292D32), // Border color #292D32
                width: 1.5, // Updated border width to 1.5px
              ),
              borderRadius: BorderRadius.circular(10), // Rounded corners
              shape: BoxShape.rectangle, // Ensures it's a rectangle
            ),
            child: IconButton(
              icon: const ImageIcon(
                AssetImage('assets/images/icon/back_arrow.png'),
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.width15,
          vertical: Dimensions.height15,
        ),
        child: GetBuilder<VerifyCodeControllerImp>(
          builder: (controller) {
            return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: ListView(
                children: [
                  HeaderAuth(
                    title: "check your mail".tr,
                    firstDesc: "Please, Enter the verification code".tr,
                    secondDesc: "Please, Enter the verification code".tr,
                  ),
                  // Directionality widget wrapping the PinCodeTextField for LTR input
                  Directionality(
                    textDirection: TextDirection.ltr, // Force LTR for PIN input
                    child: PinCodeTextField(
                      appContext: context,
                      pastedTextStyle: const TextStyle(
                        color: AppColor.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      length: 6,
                      animationType: AnimationType.fade,
                      validator: (v) {
                        if (v!.length < 6) {
                          return;
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5.r),
                        fieldHeight: Dimensions.height50,
                        fieldWidth: Dimensions.width45,
                        activeFillColor: AppColor.backgroundButton,
                        inactiveColor: Colors.grey,
                        disabledColor: Colors.grey,
                        inactiveFillColor: AppColor.backgroundButton,
                        activeColor: AppColor.backgroundButton,
                        selectedColor: AppColor.backgroundButton,
                        selectedFillColor: AppColor.backgroundButton,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
                      onCompleted: (value) {
                        // Simulate checking the pin code
                        bool isPinCorrect = controller.checkCode(value);

                        if (isPinCorrect) {
                          // Show success message if PIN is correct
                          Get.snackbar(
                            "Success".tr, // Title
                            "Congratulations, PIN is correct!".tr, // Message
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        } else {
                          // Show error message if PIN is incorrect
                          Get.snackbar(
                            "Error".tr, // Title
                            "The PIN you entered is incorrect. Try again."
                                .tr, // Message
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
