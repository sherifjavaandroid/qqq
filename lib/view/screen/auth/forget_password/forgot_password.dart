import 'package:easycut/controller/auth/forget_password_controller.dart';
import 'package:easycut/core/class/handling_data_view.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/functions/valid_input.dart';
import 'package:easycut/view/widget/auth/custom_button_auth.dart';
import 'package:easycut/view/widget/auth/custom_text_form_auth.dart';
import 'package:easycut/view/widget/auth/header_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);

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
          horizontal: Dimensions.width15.w,
          vertical: Dimensions.height15.h,
        ),
        child: GetBuilder<ForgetPasswordControllerImp>(
          builder: (controller) {
            return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Form(
                key: controller.formState,
                child: ListView(
                  children: [
                    HeaderAuth(
                      title: "check your mail".tr,
                      firstDesc: "Email is required".tr,
                      secondDesc: "enter your mail please!".tr,
                    ),
                    SizedBox(
                      height: Dimensions.height20.h,
                    ),
                    CustomTextFormAuth(
                      myController: controller.email,
                      valid: (val) {
                        return validInput(val!, 10, 100, 'email');
                      },
                      type: TextInputType.emailAddress,
                      hintText: "email".tr,
                      prefixIcon: 'assets/images/icon/sms.png',
                    ),
                    SizedBox(
                      height: Dimensions.height150.h,
                    ),
                    CustomButtonAuth(
                      onPressed: () {
                        controller.checkEmail();
                      },
                      text: "check your mail".tr,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
