import 'package:novelku/app/modules/home/home_controller.dart';
import 'package:novelku/app/pakage.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
  }
}