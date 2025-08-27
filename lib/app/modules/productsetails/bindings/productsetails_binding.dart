import 'package:get/get.dart';
import 'package:cars/app/modules/productsetails/controllers/productsetails_controller.dart';

class ProductsetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductsetailsController>(() => ProductsetailsController());
  }
}
