// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'package:location/location.dart';

import 'package:cars/app/models/frombackend/usermodel.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Rx<UserModel> currentUser = UserModel.empty().obs;
  String Token = '';

  void RefreshUserData() async {
    await UserModel.getUserById(currentUser.value.id!).then((updatedUser) {
      if (updatedUser != null) {
        currentUser.value = updatedUser;
      }
    }).catchError((error) {
      // Handle error if needed
      print('Error refreshing user data: $error');
    });
    update(); // Notify listeners about the change
  }

  Future<void> getUserWillayaFromLocation() async {
    try {
      // Use Location package to get the current location
      Location location = Location();

      bool serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          log('Location services are disabled.');
          return;
        }
      }

      PermissionStatus permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          log('Location permissions are denied.');
          return;
        }
      }

      final position = await location.getLocation();

      double latitude = position.latitude!;
      double longitude = position.longitude!;

      log('Current location: ($latitude, $longitude)');

      // Fetch the willaya using the coordinates
      String? willaya =
          await getUserWillayaFromCoordinates(latitude, longitude);

      if (willaya != null) {
        log('User willaya: $willaya');
      } else {
        log('Failed to fetch willaya');
      }
    } catch (e) {
      log('Error getting location: $e');
    }
  }

  Future<String?> getUserWillayaFromCoordinates(
      double latitude, double longitude) async {
    try {
      final url = Uri.parse(
          'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude');

      final response = await GetConnect().get(url.toString());

      if (response.statusCode == 200) {
        final data = response.body;
        if (data != null && data['address'] != null) {
          return data['address']
              ['state']; // Assuming 'state' corresponds to willaya
        }
      }
      log('Failed to fetch willaya: ${response.statusCode}');
      return null;
    } catch (e) {
      log('Error fetching willaya: $e');
      return null;
    }
  }
}
