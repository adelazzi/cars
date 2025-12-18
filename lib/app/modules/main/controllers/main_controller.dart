import 'package:cars/app/models/frombackend/usermodel.dart';
import 'package:cars/app/modules/orders/controllers/orders_controller.dart';
import 'package:cars/app/modules/profile/controllers/profile_controller.dart';
import 'package:cars/app/modules/user_controller.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  // Add your controller logic here

  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Get.find<ProfileController>().fetchMyCars();
    Get.find<UserController>().RefreshUserData();
    Get.find<OrdersController>().fetchOrders();
  }
}
