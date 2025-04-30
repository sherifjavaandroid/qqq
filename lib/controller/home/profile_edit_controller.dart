import 'dart:io';
import 'package:easycut/core/class/status_request.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/functions/handling_data_controller.dart';
import 'package:easycut/core/services/services.dart';
import 'package:easycut/data/data_source/remote/home/profile_data.dart';
import 'package:easycut/data/model/profile_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileEditController extends GetxController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

  ProfileData profileData = ProfileData(Get.find());
  MyServices myServices = Get.find();
  StatusRequest statusRequest = StatusRequest.success;

  ProfileModel currentProfile = ProfileModel();
  File? profileImage;
  bool isPasswordVisible = true;
  bool updatePassword = false;
  String originalImagePath = "";

  // API URL for profile update
  final String updateProfileUrl = 'https://dashboard.easycuteg.com/api/v1/auth/profile/update';

  togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  toggleUpdatePassword() {
    updatePassword = !updatePassword;
    if (!updatePassword) {
      passwordController.clear();
      confirmPasswordController.clear();
    }
    update();
  }

  selectImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      profileImage = File(image.path);
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();

    // Initialize controllers with current user data
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    addressController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    // Get current user data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getData();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  getData() async {
    int? userId = myServices.sharedPreferences.getInt('id');
    if (userId == null) {
      Get.offAllNamed(AppRoute.login);
      return;
    }

    statusRequest = StatusRequest.loading;
    update();

    var response = await profileData.postData(userId.toString());
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['status'] == 'success') {
        var data = response['profile'] as Map<String, dynamic>;
        currentProfile = ProfileModel.fromJson(data);

        // Fill controllers with current data
        nameController.text = currentProfile.name ?? "";
        emailController.text = currentProfile.email ?? "";
        phoneController.text = currentProfile.phone ?? "";
        addressController.text = currentProfile.address ?? "";
        originalImagePath = currentProfile.image ?? "";
      } else {
        Get.snackbar(
          'Warning'.tr,
          'Failed to load profile data'.tr,
          snackPosition: SnackPosition.TOP,
          colorText: Colors.red,
        );
        statusRequest = StatusRequest.failure;
      }
    }
    update();
  }

  Future<bool> updateProfile() async {
    var formData = formState.currentState;
    if (!formData!.validate()) return false;

    // Password validation
    if (updatePassword && passwordController.text != confirmPasswordController.text) {
      Get.snackbar(
        'Error'.tr,
        'Passwords do not match'.tr,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
      );
      return false;
    }

    statusRequest = StatusRequest.loading;
    update();

    try {
      // Prepare request data according to the API structure
      Map<String, dynamic> requestData = {
        'user_id': currentProfile.id,
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'address': addressController.text,
      };

      // Only include password if being updated
      if (updatePassword && passwordController.text.isNotEmpty) {
        requestData['password'] = passwordController.text;
      }

      // Make the API request
      final response = await http.post(
        Uri.parse(updateProfileUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(requestData),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['status'] == 'success') {
        // Handle image upload separately if needed
        bool imageUpdateSuccess = true;
        if (profileImage != null) {
          imageUpdateSuccess = await updateProfileImage();
        }

        // Update local storage with new user data
        myServices.sharedPreferences.setString('name', nameController.text);

        // Show success message
        Get.snackbar(
          'Success'.tr,
          'Profile updated successfully'.tr,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.green,
        );

        statusRequest = StatusRequest.success;
        return true && imageUpdateSuccess;
      } else {
        // Handle error
        Get.snackbar(
          'Error'.tr,
          responseData['message'] ?? 'Failed to update profile'.tr,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.red,
        );
        statusRequest = StatusRequest.failure;
        return false;
      }
    } catch (e) {
      // Handle exceptions
      Get.snackbar(
        'Error'.tr,
        'An unexpected error occurred: $e'.tr,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.red,
      );
      statusRequest = StatusRequest.serverException;
      return false;
    } finally {
      update();
    }
  }

  // Separate method to handle profile image upload
  Future<bool> updateProfileImage() async {
    try {
      if (profileImage == null) return true;

      // Implement your image upload logic here
      // This will depend on your backend API for handling image uploads
      var response = await profileData.updateProfileWithImage(
        currentProfile.id.toString(),
        profileImage!,
      );

      if (response != null && response['status'] == 'success') {
        String imageUrl = response['image'] ?? originalImagePath;
        myServices.sharedPreferences.setString('image', imageUrl);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error updating profile image: $e');
      return false;
    }
  }
}