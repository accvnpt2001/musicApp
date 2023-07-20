import 'package:get/get.dart';
import 'package:musicapp/page/favorite/favorite_controller.dart';

class FavoriteBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FavoriteController());
  }
}
