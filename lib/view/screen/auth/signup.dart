import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easycut/app.dart';
import 'package:easycut/controller/auth/signup_controller.dart';
import 'package:easycut/core/class/handling_data_view.dart';
import 'package:easycut/core/constant/color.dart';
import 'package:easycut/core/constant/dimensions.dart';
import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/functions/alert_exit.dart';
import 'package:easycut/core/functions/valid_input.dart';
import 'package:easycut/core/shared/widgets/small_text.dart';
import 'package:easycut/view/widget/auth/custom_buttom_image.dart';
import 'package:easycut/view/widget/auth/custom_button_auth.dart';
import 'package:easycut/view/widget/auth/custom_text_form_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  List<dynamic> countries = [];
  String? selectedCountry;

  @override
  void initState() {
    super.initState();
    loadCountries();
  }

  // Future<void> loadCountries() async {
  //   final String response =
  //       await rootBundle.loadString('assets/countries/countries.json');
  //   final List<dynamic> data = json.decode(response);
  //   setState(() {
  //     countries = data;
  //   });
  // }
  Future<void> loadCountries() async {
    try {
      // Load the JSON file
      final String response =
          await rootBundle.loadString('assets/countries/countries.json');

      // Decode JSON data and ensure proper typing
      final List<Map<String, dynamic>> data = (json.decode(response) as List)
          .map((e) => Map<String, dynamic>.from(e))
          .toList();

      // Update the state with the parsed data
      setState(() {
        countries = data;
      });
    } catch (e) {
      // Handle errors gracefully
      print('Error loading countries: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'register'.tr,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 32),
        ),
        bottom: PreferredSize(
            preferredSize:
                Size.fromHeight(30.0.h), // Adjust the height as needed
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.0.h), // Optional padding
              child: Text(
                'Please, fill in the form'.tr, // Subtitle text
                style: TextStyle(
                  // fontWeight: FontWeight.w100,
                  fontSize: 16.sp, // Adjust the font size as needed
                  color: Colors.grey, // Set the text color
                ),
              ),
            )),
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
                Get.offNamed(AppRoute.login);
              },
            ),
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: alertExit,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width15,
            vertical: Dimensions.height15,
          ),
          child: GetBuilder<SignUpControllerImp>(
            builder: (controller) {
              return HandlingDataRequest(
                statusRequest: controller.statusRequest,
                widget: Form(
                  key: controller.formState,
                  child: ListView(
                    children: [
                      SizedBox(height: 15.h),
                      CustomTextFormAuth(
                        myController: controller.name,
                        valid: (val) {
                          return validInput(val!, 10, 40, 'any');
                        },
                        type: TextInputType.text,
                        hintText: "user_name".tr,
                        prefixIcon: 'assets/images/icon/user.png',
                      ),
                      SizedBox(height: 10.h),
                      CustomTextFormAuth(
                        myController: controller.email,
                        valid: (val) {
                          return validEmail(val!);
                        },
                        type: TextInputType.emailAddress,
                        hintText: "email".tr,
                        prefixIcon: 'assets/images/icon/sms.png',
                      ),
                      SizedBox(height: 10.h),

                      CustomTextFormAuth(
                        myController: controller.password,
                        valid: (val) {
                          return validInput(val!, 6, 30, 'password');
                        },
                        type: TextInputType.visiblePassword,
                        obSecure: controller.isShowPassword,
                        hintText: "password".tr,
                        prefixIcon: 'assets/images/icon/lock.png',
                        suffixIcon: controller.isShowPassword
                            ? 'assets/images/icon/eye.png'
                            : 'assets/images/icon/eye_off.png',
                        suffixPressed: () {
                          controller.showPassword();
                        },
                      ),
                      SizedBox(height: 10.h),

                      // CustomTextFormAuth(
                      //   myController: controller.phone,
                      //   valid: (val) {
                      //     return null;
                      //   },
                      //   type: TextInputType.phone,
                      //   hintText: "phoneNumber".tr,
                      //   prefixIcon: Icons.phone_android,
                      // ),

                      // Country Dropdown
                      // DropdownButtonFormField<String>(
                      //   value: controller.country.text.isEmpty
                      //       ? null
                      //       : controller.country.text
                      //           .toLowerCase(), // ensure consistent lowercase values
                      //   decoration: InputDecoration(
                      //     contentPadding:
                      //         const EdgeInsets.symmetric(vertical: 16),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //     ),
                      //     hintText:
                      //         "Country".tr, // Localized hint text for country
                      //     prefixIcon: const Icon(Icons.flag,
                      //         color: AppColor.primaryColor),
                      //   ),
                      //   items: [
                      //     DropdownMenuItem(
                      //       value: 'egypt',
                      //       child:
                      //           Text("Egypt".tr), // Displayed text is "Egypt"
                      //     ),
                      //     DropdownMenuItem(
                      //       value: 'germany',
                      //       child: Text(
                      //           'Germany'.tr), // Displayed text is "Germany"
                      //     ),
                      //     DropdownMenuItem(
                      //         value: 'germany', child: Text('Germany'.tr)
                      //         // Displayed text is "Germany"
                      //         ),
                      //   ],
                      //   onChanged: (String? newValue) {
                      //     controller.country.text =
                      //         newValue ?? ''; // ensure consistent value
                      //     controller.updateStatesBasedOnCountry(
                      //         newValue!); // Fetch relevant states based on country
                      //   },
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please select a country'; // validation message
                      //     }
                      //     return null;
                      //   },
                      // ),
                      // DropdownButtonFormField<String>(
                      //   value: selectedCountry,
                      //   decoration: InputDecoration(
                      //     contentPadding:
                      //         const EdgeInsets.symmetric(vertical: 16),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(15),
                      //     ),
                      //     hintText:
                      //         "Country".tr, // Localized hint text for country
                      //     prefixIcon: const Icon(Icons.flag,
                      //         color: AppColor.primaryColor),
                      //   ),
                      //   isExpanded: true,
                      //   items: countries.map((country) {
                      //     return DropdownMenuItem<String>(
                      //       value: country[
                      //           'value'], // Unique value for each country
                      //       child: Text(
                      //         Get.locale?.languageCode == 'en'
                      //             ? country['name']!
                      //             : country['name_ar']!,
                      //         style: const TextStyle(fontSize: 14),
                      //       ),
                      //     );
                      //   }).toList(),
                      //   onChanged: (value) {
                      //     // Ensure the selected country value updates the controller
                      //     setState(() {
                      //       selectedCountry = value;
                      //     });

                      //     // Update the country field in the controller
                      //     controller.country.text = value ?? '';

                      //     // Fetch relevant states for the selected country
                      //     controller.updateStatesBasedOnCountry(value!);

                      //     // Reset the selected state to null
                      //     setState(() {
                      //       controller.selectedState = null;
                      //     });
                      //   },
                      // ),

                      // onChanged: (String? newValue) {
                      //   controller.country.text =
                      // SizedBox(
                      //   height: 10.h,
                      // ),
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 20.0),
                      //   child: DropdownButtonFormField2<String>(
                      //     isExpanded: true,
                      //     decoration: InputDecoration(
                      //       contentPadding:
                      //           const EdgeInsets.symmetric(vertical: 16),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(15),
                      //       ),
                      //     ),
                      //     hint: Text(
                      //       'Select State'.tr,
                      //       style: const TextStyle(fontSize: 14),
                      //     ),
                      //     items: controller.states
                      //         .map((item) => DropdownMenuItem<String>(
                      //               value: item.name,
                      //               child: Text(
                      //                 item.name ?? '',
                      //                 style: const TextStyle(
                      //                   fontSize: 14,
                      //                 ),
                      //               ),
                      //             ))
                      //         .toList(),
                      //     value: controller
                      //         .selectedState, // Set the current selected value
                      //     validator: (value) {
                      //       // if (value == null) {
                      //       //   return 'Please select State'.tr;
                      //       // }
                      //       return null;
                      //     },
                      //     onChanged: (value) {
                      //       controller.selectedState = value;
                      //     },
                      //   ),
                      // ),

                      // Container(
                      //   height: Dimensions.height60,
                      //   padding: const EdgeInsets.symmetric(
                      //     horizontal: 6,
                      //     vertical: 6,
                      //   ),
                      //   decoration: BoxDecoration(
                      //     border: const Border(
                      //       top: BorderSide(
                      //         color: AppColor.grey,
                      //         width: 1,
                      //       ),
                      //       left: BorderSide(
                      //         color: AppColor.grey,
                      //         width: 1,
                      //       ),
                      //       right: BorderSide(
                      //         color: AppColor.grey,
                      //         width: 1,
                      //       ),
                      //       bottom: BorderSide(
                      //         color: AppColor.grey,
                      //         width: 1,
                      //       ),
                      //     ),
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //   child: Row(
                      //     children: [
                      //       const Padding(
                      //         padding: EdgeInsets.symmetric(
                      //           horizontal: 6,
                      //         ),
                      //         child: Icon(
                      //           Icons.person_pin,
                      //           color: AppColor.primaryColor,
                      //         ),
                      //       ),
                      //       // Expanded(
                      //       //   child: GetBuilder<SignUpControllerImp>(
                      //       //     builder: (con) {
                      //       //       return DropdownButton(
                      //       //         isExpanded: true,
                      //       //         icon: const Icon(
                      //       //           Icons.arrow_drop_down,
                      //       //           color: AppColor.primaryColor,
                      //       //         ),
                      //       //         underline: const SizedBox(),
                      //       //         value: con.gender,
                      //       //         items: [
                      //       //           DropdownMenuItem(
                      //       //             value: Gender.gender,
                      //       //             onTap: () {},
                      //       //             child: Text(
                      //       //               'gender'.tr,
                      //       //               style: const TextStyle(
                      //       //                 color: AppColor.grey,
                      //       //               ),
                      //       //             ),
                      //       //           ),
                      //       //           DropdownMenuItem(
                      //       //             value: Gender.male,
                      //       //             onTap: () {},
                      //       //             child: Text(
                      //       //               'male'.tr,
                      //       //               style: const TextStyle(
                      //       //                 color: AppColor.grey,
                      //       //               ),
                      //       //             ),
                      //       //           ),
                      //       //           DropdownMenuItem(
                      //       //             value: Gender.female,
                      //       //             onTap: () {},
                      //       //             child: Text(
                      //       //               'female'.tr,
                      //       //               style: const TextStyle(
                      //       //                 color: AppColor.grey,
                      //       //               ),
                      //       //             ),
                      //       //           ),
                      //       //         ],
                      //       //         onChanged: (value) {
                      //       //           con.changeGender(value!);
                      //       //         },
                      //       //       );
                      //       //     },
                      //       //   ),
                      //       // )
                      //     ],
                      //   ),
                      // ),
                      SizedBox(
                        height: 10.h,
                      ),

                      CustomButtonImage(
                        onPressed: () async {
                          XFile? xFile = await ImagePicker().pickImage(
                            source: ImageSource.gallery,
                          );
                          controller.addFilePath(xFile!.path);
                        },
                        text: "Select Image".tr,
                        suffiximage: 'assets/images/icon/gallery-add.png',
                      ),
                      SizedBox(
                        height: Dimensions.height150.h,
                      ),

                      CustomButtonAuth(
                        onPressed: () {
                          controller.signUp();
                        },
                        text: "register".tr,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String? validEmail(String val) {
    // Regular expression to allow Gmail, Yahoo, and Hotmail addresses
    RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@(gmail|yahoo|hotmail)\.com$',
      caseSensitive: false,
    );

    if (val.isEmpty) {
      return 'Email is required'.tr;
    } else if (!emailRegExp.hasMatch(val)) {
      return 'Please enter a valid Gmail, Yahoo, or Hotmail address'.tr;
    }
    return null;
  }
}
