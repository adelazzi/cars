import 'package:cars/app/models/usermodel.dart';
import 'package:get/get.dart';

class MainController extends GetxController {
  // Add your controller logic here


  var selectedIndex = 0.obs;

  void changeIndex(int index) {
    selectedIndex.value = index;
  }


}
