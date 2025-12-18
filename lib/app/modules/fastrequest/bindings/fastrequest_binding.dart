import 'package:get/get.dart';
import 'package:cars/app/modules/fastrequest/controllers/fastrequest_controller.dart';

class FastrequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FastrequestController>(() => FastrequestController());
  }
}
