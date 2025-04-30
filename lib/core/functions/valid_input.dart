import 'package:get/get.dart';

validInput(String val, int min, int max, String type) {
  if (val.isEmpty) {
    return "nameNotValid".tr;
  }

  if (type == "name") {
    if (!GetUtils.isUsername(val)) {
      return "requiredField".tr;
    }
  }

  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "yes".tr;
    }
  }

  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "no".tr;
    }
  }

  if (val.length < min) {
    return "${"cantBeLessThan".tr} $min";
  }

  if (val.length > max) {
    return "${"cantBeGreaterThan".tr} $max";
  }
}
