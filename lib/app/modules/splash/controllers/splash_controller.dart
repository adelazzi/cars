import 'package:cars/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  // Add your controller logic here
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nextPage();
  }

  void nextPage() async {
    // Wait for 2 seconds before navigating to the next page
    await Future.delayed(Duration(seconds: 2));
    // Logic to navigate to the next page
    Get.offNamed(Routes.LOGIN);
  }
}
