import 'package:cars/app/models/usermodel.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var currentUser = UserModel.empty().obs;

  void setUser() {

    currentUser.value = UserModel(
      id: 'user_1',
      name: 'John',
      familyName: 'Doe',
      phoneNumber: '+1234567890',
      address: '456 Another St, Metropolis',
      token: 'token_abc123',
      fcmToken: 'fcm_xyz789',
      imageProfileUrl: 'https://example.com/profile.jpg',
    );
    update(); // Notify listeners about the change
  }
}
