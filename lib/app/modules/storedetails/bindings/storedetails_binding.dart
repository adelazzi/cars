import 'package:get/get.dart';
import 'package:cars/app/modules/storedetails/controllers/storedetails_controller.dart';

class StoredetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StoredetailsController>(() => StoredetailsController());
  }
}
