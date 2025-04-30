import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:easycut/controller/auth/activate_code_controller.dart';
import 'package:easycut/core/class/handling_data_view.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/view/widget/auth/header_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ActivateCode extends StatelessWidget {
  const ActivateCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr, // Set overall layout direction to RTL
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width15,
            vertical: Dimensions.height15,
          ),
          child: GetBuilder<ActivateCodeControllerImp>(
            builder: (controller) {
              return HandlingDataRequest(
                statusRequest: controller.statusRequest,
                widget: ListView(
                  children: [
                    HeaderAuth(
                      title: "goToLogin".tr,
                      firstDesc: "fullName".tr,
                      secondDesc: "${controller.email}",
                    ),
                    // Wrap PinCodeTextField in a separate Directionality widget for LTR
                    Directionality(
                      textDirection:
                          TextDirection.ltr, // Force LTR for PIN input
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
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: Dimensions.height50,
                          fieldWidth: Dimensions.width45,
                          activeFillColor: Colors.blue,
                          inactiveColor: Colors.blue,
                          disabledColor: Colors.blue,
                          inactiveFillColor: Colors.blue,
                          activeColor: Colors.blue,
                          selectedColor: Colors.blue,
                          selectedFillColor: Colors.blue,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {},
                        onCompleted: (value) {
                          controller.checkCode(value);
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
