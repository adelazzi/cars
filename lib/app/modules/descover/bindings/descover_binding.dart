import 'package:get/get.dart';
import 'package:cars/app/modules/descover/controllers/descover_controller.dart';

class DescoverBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DescoverController>(() => DescoverController());
  }
}
