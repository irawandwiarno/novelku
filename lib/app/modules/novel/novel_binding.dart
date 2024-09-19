import 'package:get/get.dart';
import 'package:novelku/app/modules/novel/novel.dart';

class NovelBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(NovelController());
  }
}