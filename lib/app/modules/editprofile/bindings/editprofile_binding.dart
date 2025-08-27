import 'package:get/get.dart';
import 'package:cars/app/modules/editprofile/controllers/editprofile_controller.dart';

class EditprofileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditprofileController>(() => EditprofileController());
  }
}
