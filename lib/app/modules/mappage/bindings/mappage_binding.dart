import 'package:get/get.dart';
import 'package:cars/app/modules/mappage/controllers/mappage_controller.dart';

class MappageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MappageController>(() => MappageController());
  }
}
