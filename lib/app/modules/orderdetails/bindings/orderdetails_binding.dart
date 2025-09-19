import 'package:get/get.dart';
import 'package:cars/app/modules/orderdetails/controllers/orderdetails_controller.dart';

class OrderdetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderdetailsController>(() => OrderdetailsController());
  }
}
