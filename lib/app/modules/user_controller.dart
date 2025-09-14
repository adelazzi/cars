// ignore_for_file: non_constant_identifier_names

import 'package:cars/app/models/frombackend/usermodel.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<UserModel> currentUser = UserModel.empty().obs;
  String Token = '';

  void RefreshUserData() async{
  await  UserModel.getUserById(currentUser.value.id!).then((updatedUser) {
      if (updatedUser != null) {
        currentUser.value = updatedUser;
      }
    }).catchError((error) {
      // Handle error if needed
      print('Error refreshing user data: $error');
    });
    update(); // Notify listeners about the change
  }


}
