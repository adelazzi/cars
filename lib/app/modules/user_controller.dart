import 'package:cars/app/models/frombackend/usermodel.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  var currentUser = UserModel.empty().obs;

  void setUser() {
    currentUser.value = UserModel(
      id: 'user_1',
      name: 'John Doe',
      phoneNumber: '+1234567890',
      address: '456 Another St, Metropolis',
      fcmToken: 'fcm_xyz789',
      profileImage: null,
      userType: UserType.client,
      verified: false,
      premium: false,
      rating: 0.0,
    );
    update(); // Notify listeners about the change
  }
}
