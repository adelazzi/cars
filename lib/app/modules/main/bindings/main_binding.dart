import 'package:cars/app/modules/explore/controllers/explore_controller.dart';
import 'package:cars/app/modules/home/controllers/home_controller.dart';
import 'package:cars/app/modules/orders/controllers/orders_controller.dart';
import 'package:cars/app/modules/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';
import 'package:cars/app/modules/main/controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ExploreController>(() => ExploreController());
    Get.lazyPut<OrdersController>(() => OrdersController());
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
