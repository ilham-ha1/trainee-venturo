import 'package:get/get.dart';

class NavigationController extends GetxController {
  static NavigationController get to => Get.find();
  final RxInt tabIndex = 0.obs;

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }
}
