import 'package:easycut/controller/home/profile_edit_controller.dart';
import 'package:easycut/core/class/handling_data_view.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/functions/valid_input.dart';
import 'package:easycut/linkapi.dart';
import 'package:easycut/view/widget/auth/custom_button_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileEditController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Edit Profile'.tr,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF292D32),
                width: 1.5.w,
              ),
              borderRadius: BorderRadius.circular(10.r),
              shape: BoxShape.rectangle,
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
      body: GetBuilder<ProfileEditController>(
        builder: (controller) {
          return HandlingDataView(
            statusRequest: controller.statusRequest,
            widget: SingleChildScrollView(
              child: Form(
                key: controller.formState,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Profile Image
                      Center(
                        child: Stack(
                          children: [
                            Container(
                              height: 120.h,
                              width: 120.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColor.backgroundicons2,
                                  width: 2.w,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(60.r),
                                child: controller.profileImage != null
                                    ? Image.file(
                                  controller.profileImage!,
                                  fit: BoxFit.cover,
                                )
                                    : controller.originalImagePath.isNotEmpty
                                    ? Image.network(
                                  "${AppLink.imageUsers}${controller.originalImagePath}",
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'assets/images/icon/user.png',
                                      fit: BoxFit.cover,
                                    );
                                  },
                                )
                                    : Image.asset(
                                  'assets/images/icon/user.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  controller.selectImage();
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 40.w,
                                  decoration: BoxDecoration(
                                    color: AppColor.selectedColor,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2.w,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.camera_alt,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30.h),

                      // Name Field
                      _buildLabel('Full Name'.tr),
                      SizedBox(height: 8.h),
                      _buildTextField(
                        controller: controller.nameController,
                        hint: 'Enter your full name'.tr,
                        prefixIcon: 'assets/images/icon/user.png',
                        validator: (val) {
                          return validInput(val!, 3, 50, 'name');
                        },
                      ),
                      SizedBox(height: 20.h),

                      // Email Field
                      _buildLabel('Email'.tr),
                      SizedBox(height: 8.h),
                      _buildTextField(
                        controller: controller.emailController,
                        hint: 'Enter your email'.tr,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: 'assets/images/icon/sms.png',
                        validator: (val) {
                          return validInput(val!, 5, 100, 'email');
                        },
                      ),
                      SizedBox(height: 20.h),

                      // Phone Field
                      _buildLabel('Phone Number'.tr),
                      SizedBox(height: 8.h),
                      _buildTextField(
                        controller: controller.phoneController,
                        hint: 'Enter your phone number'.tr,
                        keyboardType: TextInputType.phone,
                        prefixIcon: 'assets/images/icon/call-calling.png',
                        validator: (val) {
                          return validInput(val!, 7, 15, 'phone');
                        },
                      ),
                      SizedBox(height: 20.h),

                      // Address Field
                      _buildLabel('Address'.tr),
                      SizedBox(height: 8.h),
                      _buildTextField(
                        controller: controller.addressController,
                        hint: 'Enter your address'.tr,
                        prefixIcon: 'assets/images/icon/location.png',
                        validator: (val) {
                          return validInput(val!, 5, 100, 'any');
                        },
                      ),
                      SizedBox(height: 20.h),

                      // Change Password Option
                      Row(
                        children: [
                          SizedBox(
                            height: 24.h,
                            width: 24.w,
                            child: Checkbox(
                              value: controller.updatePassword,
                              activeColor: AppColor.selectedColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              onChanged: (value) {
                                controller.toggleUpdatePassword();
                              },
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Change Password'.tr,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),

                      // Password Fields (only visible if updatePassword is true)
                      if (controller.updatePassword) ...[
                        _buildLabel('New Password'.tr),
                        SizedBox(height: 8.h),
                        _buildTextField(
                          controller: controller.passwordController,
                          hint: 'Enter new password'.tr,
                          prefixIcon: 'assets/images/icon/lock.png',
                          isPassword: true,
                          isPasswordVisible: controller.isPasswordVisible,
                          onTogglePassword: () {
                            controller.togglePasswordVisibility();
                          },
                          validator: (val) {
                            return validInput(val!, 6, 30, 'password');
                          },
                        ),
                        SizedBox(height: 20.h),

                        _buildLabel('Confirm Password'.tr),
                        SizedBox(height: 8.h),
                        _buildTextField(
                          controller: controller.confirmPasswordController,
                          hint: 'Confirm new password'.tr,
                          prefixIcon: 'assets/images/icon/lock.png',
                          isPassword: true,
                          isPasswordVisible: controller.isPasswordVisible,
                          onTogglePassword: () {
                            controller.togglePasswordVisibility();
                          },
                          validator: (val) {
                            if (val != controller.passwordController.text) {
                              return 'Passwords do not match'.tr;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20.h),
                      ],

                      // Save Button
                      CustomButtonAuth(
                        text: 'Save Changes'.tr,
                        onPressed: () async {
                          final success = await controller.updateProfile();
                          if (success) {
                            Get.back();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: AppColor.mainBlackColor,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required String prefixIcon,
    required String? Function(String?) validator,
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    bool isPasswordVisible = true,
    VoidCallback? onTogglePassword,
  }) {
    return Container(
      height: 51.h,
      decoration: BoxDecoration(
        color: AppColor.backgroundButton,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColor.backgroundicons2,
          width: 1.w,
        ),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: isPassword ? isPasswordVisible : false,
        validator: validator,
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColor.mainBlackColor,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            fontSize: 16.sp,
            color: AppColor.grey,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          border: InputBorder.none,
          prefixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 10.w),
              Image.asset(
                prefixIcon,
                height: 22.h,
                width: 22.w,
              ),
              Container(
                height: 20.h,
                width: 2.w,
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                color: AppColor.backgroundicons,
              ),
            ],
          ),
          suffixIcon: isPassword
              ? IconButton(
            onPressed: onTogglePassword,
            icon: Image.asset(
              isPasswordVisible
                  ? 'assets/images/icon/eye.png'
                  : 'assets/images/icon/eye_off.png',
              height: 22.h,
              width: 22.w,
            ),
          )
              : null,
        ),
      ),
    );
  }
}