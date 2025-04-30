import 'package:easycut/controller/auth/activate_code_controller.dart';
import 'package:easycut/controller/auth/forget_password_controller.dart';
import 'package:easycut/controller/auth/login_controller.dart';
import 'package:easycut/controller/auth/reset_password_controller.dart';
import 'package:easycut/controller/auth/signup_controller.dart';
import 'package:easycut/controller/auth/verify_code_controller.dart';
import 'package:easycut/controller/home/home_controller.dart';
import 'package:easycut/controller/onboarding_controller.dart';
import 'package:easycut/core/class/crud.dart';
import 'package:get/get.dart';

class MyBinding extends Bindings {
  @override
  void dependencies() {
    // ============== CRUD Operations
    Get.put(Crud());
    // ============== On Boarding Controller
    Get.lazyPut(() => OnBoardingControllerImp(), fenix: true);
    // ============== Auth Controller
    Get.lazyPut(() => LoginControllerImp(), fenix: true);
    Get.lazyPut(() => SignUpControllerImp(), fenix: true);
    Get.lazyPut(() => ForgetPasswordControllerImp(), fenix: true);
    Get.lazyPut(() => VerifyCodeControllerImp(), fenix: true);
    Get.lazyPut(() => ResetPasswordControllerImp(), fenix: true);
    Get.lazyPut(() => ActivateCodeControllerImp(), fenix: true);
    // ============== Home Controller
    Get.lazyPut(() => HomeControllerImp(), fenix: true);
    // ============== Main Controller
    // Get.lazyPut(() => SalonDetailControllerImp());
  }
}
