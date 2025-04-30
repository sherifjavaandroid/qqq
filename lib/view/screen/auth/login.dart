import 'package:easycut/app.dart';
import 'package:easycut/controller/auth/login_controller.dart';
import 'package:easycut/core/class/handling_data_view.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/functions/alert_exit.dart';
import 'package:easycut/core/functions/valid_input.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/view/widget/auth/custom_button_auth.dart';
import 'package:easycut/view/widget/auth/custom_text_form_auth.dart';
import 'package:easycut/view/widget/auth/header_auth.dart';
import 'package:easycut/view/widget/exitdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          final shouldPop = await showExitConfirmationDialog(context);
          return shouldPop ?? false;
        },
        child: GetBuilder<LoginControllerImp>(
          builder: (controller) {
            return HandlingDataRequest(
              statusRequest: controller.statusRequest,
              widget: Form(
                key: controller.formState,
                child: ListView(
                  children: [
                    Column(
                      children: [
                        HeaderAuth(
                          title: "welcome".tr,
                          //   firstDesc: "happyToSeeYou".tr,
                          secondDesc: "loginNow".tr,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    CustomTextFormAuth(
                      myController: controller.email,
                      valid: (val) {
                        return validInput(val!, 10, 100, 'email');
                      },
                      type: TextInputType.emailAddress,
                      hintText: "email".tr,
                      decoration: const InputDecoration(),
                      prefixIcon: 'assets/images/icon/sms.png',
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomTextFormAuth(
                      myController: controller.password,
                      valid: (val) {
                        return validInput(val!, 6, 20, 'password');
                      },
                      type: TextInputType.visiblePassword,
                      obSecure: controller.isShowPassword,
                      suffixPressed: () {
                        controller.showPassword();
                      },
                      hintText: "password".tr,
                      // prefixIcon: Icons.lock_outline,
                      suffixIcon: controller.isShowPassword
                          ? 'assets/images/icon/eye.png'
                          : 'assets/images/icon/eye_off.png',

                      prefixIcon: 'assets/images/icon/lock.png',
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.goToForgetPassword();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 38, left: 38, bottom: 50),
                        child: Text(
                          "forgetPassword".tr,
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            decoration: TextDecoration
                                .underline, // Add underline to input text

                            color: AppColor.unSelectedColor,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    CustomButtonAuth(
                      onPressed: () {
                        controller.login();
                      },
                      text: "login".tr,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmallText(
                            text: "dontHaveAccount".tr,
                            color: Colors.black54,
                          ),
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              controller.goToSignUp();
                            },
                            child: SmallText(
                              text: "register".tr,
                              color: AppColor.unSelectedColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
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
