import 'dart:convert';
import 'dart:io';
import 'package:easycut/core/class/status_request.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/functions/handling_data_controller.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/data/data_source/remote/auth/signup.dart';
import 'package:easycut/linkapi.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

abstract class SignUpController extends GetxController {
  signUp();
  goBackLogin();
  changeGender(Gender value);
}

class SignUpControllerImp extends SignUpController {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  late TextEditingController name;
  late TextEditingController email;
  late TextEditingController phone;
  late TextEditingController password;
  String? _selectedState;
  late Gender gender;
  List<StateModel> _states = [];
  bool isShowPassword = true;
  late TextEditingController country;
  File? myFile;
  SignUpData signUpData = SignUpData(Get.find());
  StatusRequest statusRequest = StatusRequest.success;

  // Getter and setter for selected state
  String? get selectedState => _selectedState;
  set selectedState(String? value) {
    _selectedState = value;
    update(); // Updates the UI when the state changes
  }

  // Getter and setter for states list
  List<StateModel> get states => _states;
  set states(List<StateModel> value) {
    _states = value;
    update(); // Updates the UI when the states list changes
  }

  // Method to toggle password visibility
  showPassword() {
    isShowPassword = !isShowPassword;
    update(); // Updates the UI when the password visibility changes
  }

  // Method to go back to the login screen
  @override
  goBackLogin() {
    Get.offNamed(AppRoute.login);
  }

  // Method to handle image file addition
  void addFilePath(String path) {
    myFile = File(path);
    update(); // Updates the UI when a file is added
  }

  void updateStatesBasedOnCountry(String country) {
    if (country.isNotEmpty) {
      getStates(
          country); // Call the getStates method to fetch states based on the country
    }
  }

  // Signup method with validation and data submission
  @override
  signUp() async {
    if (myFile == null) {
      return Get.defaultDialog(
        title: "Warning".tr,
        content: SmallText(
          text: "You must upload an image for your profile".tr,
        ),
      );
    }

    var formData = formState.currentState;
    if (formData!.validate()) {
      statusRequest = StatusRequest.loading;
      // if (gender == Gender.gender) {
      //   gender = Gender.male; // Default to male if gender is not selected
      // }
      // update();

      var response = await signUpData.postData(
        name.text,
        email.text,
        password.text,
        phone.text,
        gender.name,
        country.text,
        selectedState ?? '',
        myFile!,
      );

      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        if (response['status'] == 'success') {
          Get.snackbar(
            'Register Success'.tr,
            'Your Register is successfully.Go to your account to get verify code'
                .tr,
            snackPosition: SnackPosition.BOTTOM,
            colorText: Colors.green,
          );
          Get.toNamed(AppRoute.activateCode, arguments: {
            'email': email.text,
          });
        } else {
          Get.snackbar(
            'Warning'.tr,
            'Email Already Exists'.tr,
            snackPosition: SnackPosition.TOP,
            colorText: Colors.red,
          );
          statusRequest = StatusRequest.failure;
        }
      }
      update();
    }
  }

  // Method to fetch states based on the selected country
  getStates(String country) async {
    var response = await http.get(
      Uri.parse('${AppLink.viewCountries}?country=$country'),
    );

    if (response.statusCode == 200) {
      try {
        if (kDebugMode) {
          print("Raw response: ${response.body}");
        }

        // Decode the response body into a list of state names
        final List<dynamic> jsonList =
            jsonDecode(response.body) as List<dynamic>;

        // Map the response to the _states variable
        states = jsonList
            .map((state) => StateModel(name: state.toString()))
            .toList();
        if (kDebugMode) {
          print("States parsed successfully for country $country: $_states");
        }
      } catch (e) {
        if (kDebugMode) {
          print("Error parsing states: $e");
        }
      }
    } else {
      if (kDebugMode) {
        print(
            "Error fetching states for country $country: ${response.statusCode}");
      }
    }
  }

  // Method to change the selected gender
  @override
  changeGender(Gender value) {
    gender = value;
    update(); // Updates the UI when gender changes
  }

  // Initialize controllers and set up listeners
  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();
    name = TextEditingController();
    phone = TextEditingController();
    country = TextEditingController();
    gender = Gender.gender;

    // Listen to country field changes to update the states list
    country.addListener(() {
      if (country.text.isNotEmpty) {
        getStates(country.text);
      }
    });

    super.onInit();
  }

  // Dispose of the controllers
  @override
  void dispose() {
    email.dispose();
    name.dispose();
    phone.dispose();
    password.dispose();
    country.dispose();
    super.dispose();
  }
}

// Gender enum
enum Gender {
  gender,
  male,
  female,
}

// Example StateModel class
class StateModel {
  final String? name;

  StateModel({this.name});
}
