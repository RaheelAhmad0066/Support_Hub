import 'package:get/get.dart';

class GroundBottomNavBarController extends GetxController {
  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }
}