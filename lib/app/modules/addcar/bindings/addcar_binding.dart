import 'package:get/get.dart';
import 'package:cars/app/modules/addcar/controllers/addcar_controller.dart';

class AddcarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddcarController>(() => AddcarController());
  }
}
