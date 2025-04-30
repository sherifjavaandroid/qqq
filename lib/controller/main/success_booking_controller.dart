import 'package:get/get.dart';

abstract class SuccessBookingController extends GetxController {}

class SuccessBookingControllerImp extends SuccessBookingController {
  String? total;
  String? time;
  String? endTime;
  String? day;
  String? salonName;
  String? chair;

  @override
  void onInit() {
    total = Get.arguments['total'];
    time = Get.arguments['start'];
    endTime = Get.arguments['end'];
    day = Get.arguments['day'];
    salonName = Get.arguments['salon'];
    chair = Get.arguments['chair'];
    super.onInit();
  }
}
