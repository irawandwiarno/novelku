import 'package:novelku/app/modules/add_novel/add_novel.dart';
import 'package:novelku/app/modules/home/home_controller.dart';
import 'package:novelku/app/pakage.dart';

class AddnovBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddNovelController());
  }
}