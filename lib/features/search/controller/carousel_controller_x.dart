import 'package:get/get.dart';

class CarouselControllerX extends GetxController {
  var currentIndex = 0.obs; // Observable for tracking index

  void updateIndex(int index) {
    currentIndex.value = index;
  }
}
