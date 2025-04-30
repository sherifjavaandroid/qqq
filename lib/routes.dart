import 'package:easycut/core/constant/routes.dart';
import 'package:easycut/core/middleware/my_middleware.dart';
import 'package:easycut/view/screen/auth/activate_code.dart';
import 'package:easycut/view/screen/auth/forget_password/forgot_password.dart';
import 'package:easycut/view/screen/auth/forget_password/reset_password.dart';
import 'package:easycut/view/screen/auth/forget_password/verify_code.dart';
import 'package:easycut/view/screen/auth/login.dart';
import 'package:easycut/view/screen/auth/signup.dart';
import 'package:easycut/view/screen/auth/success.dart';
import 'package:easycut/view/screen/home.dart';
import 'package:easycut/view/screen/home/booking_cancel.dart';
import 'package:easycut/view/screen/home/booking_rate.dart';
import 'package:easycut/view/screen/home/profile_edit.dart';
import 'package:easycut/view/screen/home/reschadule_booking.dart';
import 'package:easycut/view/screen/home/search_salon.dart';
import 'package:easycut/view/screen/language.dart';
import 'package:easycut/view/screen/main/book_salon_view.dart';
import 'package:easycut/view/screen/main/salon_details.dart';
import 'package:easycut/view/screen/main/success_booking.dart';
import 'package:easycut/view/screen/onboarding.dart';
import 'package:easycut/view/screen/splashScreen/splash_screen.dart';
import 'package:get/get.dart';


List<GetPage<dynamic>>? routes = [
  // =================== On Boarding ======================
  GetPage(
    name: "/",
    page: () => const SplashScreen(),
    middlewares: [
      MyMiddleware(),
    ],
  ),
  // GetPage(
  //   name: "/",
  //   page: () => const TestView(),
  // ),
  GetPage(
    name: AppRoute.languagescreen,
    page: () => const Language(),
  ),
  GetPage(
    name: AppRoute.onBoarding,
    page: () => const OnBoarding(),
  ),
  GetPage(
    name: AppRoute.home,
    page: () => const Home(),
  ),
  GetPage(
    name: AppRoute.searchSalon,
    page: () => const SearchSalon(),
  ),
  // ===================     Auth    ======================
  GetPage(
    name: AppRoute.login,
    page: () => const Login(),
  ),
  GetPage(
    name: AppRoute.signUp,
    page: () => const SignUp(),
  ),
  GetPage(
    name: AppRoute.forgetPassword,
    page: () => const ForgotPassword(),
  ),
  GetPage(
    name: AppRoute.verifyCode,
    page: () => const VerifyCode(),
  ),
  GetPage(
    name: AppRoute.resetPassword,
    page: () => const ResetPassword(),
  ),
  GetPage(
    name: AppRoute.activateCode,
    page: () => const ActivateCode(),
  ),
  GetPage(
    name: AppRoute.success,
    page: () => const Success(),
  ),

  // ===================     Booking Management    ======================
  GetPage(
    name: AppRoute.bookingCancellation,
    page: () => const BookingCancellationScreen(),
  ),
  GetPage(
    name: AppRoute.rescheduleBooking,
    page: () => const RescheduleBookingScreen(),
  ),
  GetPage(
    name: AppRoute.rateBooking,
    page: () => const BookingRatingScreen(),
  ),

  // ===================     Home    ======================
  GetPage(
    name: AppRoute.salonDetails,
    page: () => const SalonDetails(),
  ),
  GetPage(
    name: AppRoute.bookSalonView,
    page: () => const BookSalonView(),
  ),
  GetPage(
    name: AppRoute.successBooking,
    page: () => const SuccessBokking(),
  ),
  GetPage(
    name: AppRoute.profileEdit,
    page: () => const ProfileEditScreen(),
  ),
];