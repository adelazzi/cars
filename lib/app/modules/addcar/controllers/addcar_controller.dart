import 'package:get/get.dart';
import 'package:cars/app/models/frombackend/carmodel.dart';

class AddcarController extends GetxController {
  Future<void> addCar(Car car) async {
    try {
      await Car.create(car);
      Get.snackbar('Success', 'Car added successfully');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
