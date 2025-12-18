// ignore_for_file: camel_case_types

import 'dart:developer';
import 'dart:io';

import 'package:cars/app/core/constants/end_points_constants.dart';
import 'package:cars/app/core/constants/storage_keys_constants.dart';
import 'package:cars/app/core/services/http_client_service.dart';
import 'package:cars/app/core/services/local_storage_service.dart';
import 'package:cars/app/models/api_response.dart';
import 'package:cars/app/models/pagination_model.dart';
import 'package:cars/app/modules/register/controllers/register_controller.dart';
import 'package:cars/app/modules/user_controller.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

class User_brands {
  int id;
  String name;
  String image;
  User_brands(this.id, this.name, this.image);

  static Future<List<User_brands>> fetchAllBrands() async {
    try {
      final response = await HttpClientService.sendRequest(
        endPoint: EndPointsConstants.allBrands,
        requestType: HttpRequestTypes.get,
        onSuccess: (apiResponse) {
          log('Fetched all brands successfully: ${apiResponse.body}');
        },
        onError: (errors, apiResponse) {
          log('Failed to fetch brands: ${errors.join(', ')}');
        },
      );

      if (response != null && response.body != null) {
        final List<dynamic> brands = response.body as List<dynamic>;
        return brands
            .map((brand) => User_brands(
                  brand['id'] as int,
                  brand['name'] as String,
                  brand['image'] as String? ?? '',
                ))
            .toList();
      }
    } catch (e) {
      log('Error during fetching brands: $e');
    }
    return [];
  }

  static Future<List<User_brands>> fetchTopBrands() async {
    try {
      final response = await HttpClientService.sendRequest(
        endPoint: EndPointsConstants.topBrands,
        requestType: HttpRequestTypes.get,
        onSuccess: (apiResponse) {
          log('Fetched top brands successfully ');
        },
        onError: (errors, apiResponse) {
          log('Failed to fetch top brands: ${errors.join(', ')}');
        },
      );

      if (response != null && response.body != null) {
        final List<dynamic> brands = response.body as List<dynamic>;
        return brands
            .map((brand) => User_brands(
                  brand['id'] as int,
                  brand['name'] as String,
                  brand['image'] as String,
                ))
            .toList();
      }
    } catch (e) {
      log('Error during fetching top brands: $e');
    }
    return [];
  }
}

enum UserType {
  client,
  store;

  String get displayName {
    switch (this) {
      case UserType.client:
        return 'Client';
      case UserType.store:
        return 'Store';
    }
  }

  String get value {
    switch (this) {
      case UserType.client:
        return 'client';
      case UserType.store:
        return 'store';
    }
  }

  static UserType fromDisplayName(String name) {
    return UserType.values.firstWhere(
      (type) => type.displayName == name,
      orElse: () => UserType.client,
    );
  }
}

class UserModel {
  int? id;
  String? name;
  String? email;
  String? password; // Added password field
  String? username; // Added username field
  String? firstName; // Added first_name field
  String? lastName; // Added last_name field
  String? address;
  String? wilaya;
  String? commune;
  String? phoneNumber;
  String? fcmToken;
  String? birthDate;
  String? weekend;
  bool? disponible;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserType userType;
  String? profileImage;
  bool verified;
  bool premium;
  double rating;
  List<User_brands>? brands;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password, // Added password field
    this.username, // Added username field
    this.firstName, // Added first_name field
    this.lastName, // Added last_name field
    this.address,
    this.wilaya,
    this.commune,
    this.phoneNumber,
    this.fcmToken,
    this.birthDate,
    this.weekend,
    this.disponible,
    this.createdAt,
    this.updatedAt,
    this.userType = UserType.client,
    this.profileImage,
    this.verified = false,
    this.premium = false,
    this.rating = 0.0,
    this.brands,
  }) {
    brands ??= [];
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?, // Added password field
      username: json['username'] as String?, // Added username field
      firstName: json['first_name'] as String?, // Added first_name field
      lastName: json['last_name'] as String?, // Added last_name field
      address: json['address'] as String?,
      wilaya: json['wilaya'] as String?,
      commune: json['commune'] as String?,
      phoneNumber: json['phone_number'] as String?,
      fcmToken: json['fcm_token'] as String?,
      birthDate: json['birth_date'] as String?,
      weekend: json['weekend'] as String?,
      disponible: json['disponible'] as bool?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      userType: UserType.values.firstWhere(
        (e) => e.toString().split('.').last == json['user_type'],
        orElse: () => UserType.client,
      ),
      profileImage: json['profile_image'] as String?,
      verified: json['verfied'] as bool? ?? false,
      premium: json['premuim'] as bool? ?? false,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      brands: (json['brands'] as List<dynamic>?)
          ?.map((brand) => User_brands(
                brand['id'] as int,
                brand['name'] as String,
                brand['image'] as String,
              ))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password, // Added password field
      'username': username, // Added username field
      'first_name': firstName, // Added first_name field
      'last_name': lastName, // Added last_name field
      'address': address,
      'wilaya': wilaya,
      'commune': commune,
      'phone_number': phoneNumber,
      'fcm_token': fcmToken,
      'birth_date': birthDate,
      'weekend': weekend,
      'disponible': disponible,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'user_type': userType.value,
      'profile_image': profileImage,
      'verified': verified,
      'premium': premium,
      'rating': rating,
      'brands': brands?.map((brand) => brand.id).toList(),
    };
  }

  static UserModel empty() {
    return UserModel(
      id: 0,
      name: '',
      email: '',
      password: '', // Added password field
      username: '', // Added username field
      firstName: '', // Added first_name field
      lastName: '', // Added last_name field
      address: '',
      wilaya: '',
      commune: '',
      phoneNumber: '',
      fcmToken: '',
      birthDate: null,
      weekend: '',
      disponible: true,
      createdAt: null,
      updatedAt: null,
      userType: UserType.client,
      profileImage: '',
      verified: false,
      premium: false,
      rating: 0.0,
    );
  }

/////// API Methods ///////

  static Future<UserModel?> login({
    required String email,
    required String password,
    required String fcmToken,
  }) async {
    try {
      final response = await HttpClientService.sendRequest(
        endPoint: EndPointsConstants.login,
        requestType: HttpRequestTypes.post,
        data: {
          'email': email,
          'password': password,
          'fcm_token': fcmToken,
        },
        onSuccess: (apiResponse) {
          final responseBody = apiResponse.body;
          if (responseBody != null && responseBody['token'] != null) {
            Get.find<UserController>().Token = responseBody['token'];

            final userJson = responseBody['user'] as Map<String, dynamic>;
            log('Login successful: ${apiResponse.body}');
            return UserModel.fromJson(userJson);
          }
        },
        onError: (errors, apiResponse) {
          if (apiResponse.body != null && apiResponse.body['error'] != null) {
            final errorDetails = apiResponse.body['error'];
            log('Login error details: $errorDetails');

            return null;
          }
        },
      );

      if (response != null && response.body != null) {
        final userJson = response.body['user'] as Map<String, dynamic>;
        return UserModel.fromJson(userJson);
      }
    } catch (e) {
      log('Error during login: $e');
    }
    return null;
  }

  static Future<UserModel?> register(UserModel user) async {
    try {
      final response = await HttpClientService.sendRequest(
        endPoint: EndPointsConstants.register,
        requestType: HttpRequestTypes.post,
        data: user.toJson(),
        onSuccess: (apiResponse) async {
          final responseBody = apiResponse.body;
          if (responseBody != null && responseBody['token'] != null) {
            Get.find<UserController>().Token = responseBody['token'];

            await LocalStorageService.saveData(
              key: StorageKeysConstants.userToken,
              value: responseBody['token'],
              type: DataTypes.string,
            );
            await LocalStorageService.saveData(
              key: StorageKeysConstants.userId,
              value: responseBody['user']['id'],
              type: DataTypes.int,
            );

            final userJson = responseBody['user'] as Map<String, dynamic>;
            return UserModel.fromJson(userJson);
          }
          log('Registration successful: ${apiResponse.body}');
        },
        onError: (errors, apiResponse) {
          if (apiResponse.body != null && apiResponse.body['error'] != null) {
            final errorDetails =
                apiResponse.body['error'] as Map<String, dynamic>;
            // Check if the error contains the 'email' key
            if (errorDetails.containsKey('email')) {
              final emailError = errorDetails['email'] as List<dynamic>;
              Get.find<RegisterController>().emailerrortext!.value =
                  emailError.isNotEmpty
                      ? emailError.first.toString()
                      : 'Invalid email';
            }
            errorDetails.forEach((key, value) {
              log('Registration error - $key: ${value.join(', ')}');
            });
          } else {
            log('Registration failed: ${errors.join(',')}');
          }
        },
      );

      if (response != null && response.body != null) {
        Get.find<UserController>().Token = response.body['token'];

        await LocalStorageService.saveData(
          key: StorageKeysConstants.userToken,
          value: response.body['token'],
          type: DataTypes.string,
        );

        final userJson = response.body['user'] as Map<String, dynamic>;
        return UserModel.fromJson(userJson);
      }
    } catch (e) {
      log('Error during registration: $e');
    }
    return null;
  }

  static Future<bool> checkUserName(String userName) async {
    try {
      final response = await HttpClientService.sendRequest(
        endPoint: '/auth/check-username',
        requestType: HttpRequestTypes.get,
        queryParameters: {'username': userName},
        onSuccess: (apiResponse) {
          log('Username check successful: ${apiResponse.body}');
        },
        onError: (errors, apiResponse) {
          log('Username check failed: ${errors.join(', ')}');
        },
      );

      if (response != null && response.body != null) {
        return response.body['available'] as bool? ?? false;
      }
    } catch (e) {
      log('Error during username check: $e');
    }
    return false;
  }

  static Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await HttpClientService.sendRequest(
        endPoint: '/auth/change-password',
        requestType: HttpRequestTypes.post,
        data: {
          'current_password': currentPassword,
          'new_password': newPassword,
        },
        onSuccess: (apiResponse) {
          log('Password change successful: ${apiResponse.body}');
        },
        onError: (errors, apiResponse) {
          log('Password change failed: ${errors.join(', ')}');
        },
      );

      if (response != null && response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log('Error during password change: $e');
    }
    return false;
  }

  static Future<PaginationModel<UserModel>> fetchAllStores() async {
    try {
      final response = await HttpClientService.sendRequest(
        endPoint: EndPointsConstants.allStores,
        requestType: HttpRequestTypes.get,
        onSuccess: (apiResponse) {
          log('Fetched all stores successfully');
        },
        onError: (errors, apiResponse) {
          log('Failed to fetch stores: ${errors.join(', ')}');
        },
      );

      if (response != null && response.body != null) {
        return PaginationModel<UserModel>.fromJson(
          response.body as Map<String, dynamic>, 
          (json) => UserModel.fromJson(json)
        );
      }
    } catch (e) {
      log('Error during fetching stores: $e');
    }
    return PaginationModel<UserModel>(results: []);
  }

  static Future<List<UserModel>> fetchAllClients() async {
    try {
      final response = await HttpClientService.sendRequest(
        endPoint: '/stores', // TODO change this
        requestType: HttpRequestTypes.get,
        onSuccess: (apiResponse) {
          log('Fetched all stores successfully: ${apiResponse.body}');
        },
        onError: (errors, apiResponse) {
          log('Failed to fetch stores: ${errors.join(', ')}');
        },
      );

      if (response != null && response.body != null) {
        final List<dynamic> stores = response.body as List<dynamic>;
        return stores.map((store) => UserModel.fromJson(store)).toList();
      }
    } catch (e) {
      log('Error during fetching stores: $e');
    }
    return [];
  }

  static Future<UserModel?> updateUser(UserModel user) async {
    try {
      final response = await HttpClientService.sendRequest(
        endPoint: '/users/${user.id}',
        requestType: HttpRequestTypes.put,
        data: user.toJson(),
        onSuccess: (apiResponse) {
          log('User update successful: ${apiResponse.body}');
        },
        onError: (errors, apiResponse) {
          log('User update failed: ${errors.join(', ')}');
        },
      );

      if (response != null && response.body != null) {
        return UserModel.fromJson(response.body);
      }
    } catch (e) {
      log('Error during user update: $e');
    }
    return null;
  }

  static Future<bool> deleteUser(String userId) async {
    try {
      final response = await HttpClientService.sendRequest(
        endPoint: '/users/$userId',
        requestType: HttpRequestTypes.delete,
        onSuccess: (apiResponse) {
          log('User deletion successful: ${apiResponse.body}');
        },
        onError: (errors, apiResponse) {
          log('User deletion failed: ${errors.join(', ')}');
        },
      );

      if (response != null && response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log('Error during user deletion: $e');
    }
    return false;
  }

  static Future<bool> uploadProfileImage({
    required int userId,
    required String filePath,
  }) async {
    try {
      // Verify file exists before attempting upload
      final file = File(filePath);
      if (!await file.exists()) {
        log('Error: Profile image file not found at path: $filePath');
        return false;
      }

      // Create FormData with file
      final formData = dio.FormData.fromMap({
        'profile_image': await dio.MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
      });

      final response = await HttpClientService.sendRequest(
        endPoint: EndPointsConstants.userApi + '/$userId/upload-profile-image/',
        requestType: HttpRequestTypes.post,
        header: {
          'Content-Type': 'multipart/form-data',
          'authorization': 'Bearer ${Get.find<UserController>().Token}',
        },
        data: formData,
        onSuccess: (apiResponse) {
          if (apiResponse.body != null &&
              apiResponse.body['profile_image'] != null) {
            Get.find<UserController>().currentUser.value.profileImage =
                apiResponse.body['profile_image'] as String?;
            log('Profile image upload successful: ${apiResponse.body}');
          } else {
            log('Profile image upload successful but no image URL returned');
          }
        },
        onError: (errors, apiResponse) {
          final errorMessage = errors.isNotEmpty
              ? errors.join(', ')
              : 'An unknown error occurred';
          log('Profile image upload failed: $errorMessage');
          if (apiResponse?.body != null) {
            log('Error details: ${apiResponse!.body}');
          }
        },
        onProgress: (sent, total) {
          if (total > 0) {
            final progress = (sent / total * 100).toStringAsFixed(0);
            log('Upload progress: $progress%');
          }
        },
      );

      return response?.statusCode == 200 ||
          response?.requestStatus == RequestStatus.success;
    } catch (e, stackTrace) {
      log('Error during profile image upload: $e');
      log('Stack trace: $stackTrace');
      return false;
    }
  }

  static Future<UserModel?> getUserById(int userId) async {
    try {
      final response = await HttpClientService.sendRequest(
        endPoint: EndPointsConstants.userApi + '/$userId/',
        requestType: HttpRequestTypes.get,
        header: {
          'authorization': 'Bearer ${Get.find<UserController>().Token}',
        },
        onSuccess: (apiResponse) {
          log('Fetched user successfully');
        },
        onError: (errors, apiResponse) {
          log('Failed to fetch user: ${errors.join(', ')}');
        },
      );

      if (response != null && response.body != null) {
        return UserModel.fromJson(response.body);
      }
    } catch (e) {
      log('Error during fetching user: $e');
    }
    return null;
  }

  static Future<bool> logout() async {
    try {
      final response = await HttpClientService.sendRequest(
        endPoint: EndPointsConstants.logout,
        requestType: HttpRequestTypes.post,
        header: {
          'authorization': 'Bearer ${Get.find<UserController>().Token}',
        },
        onSuccess: (apiResponse) async {
          log('Logout successful: ${apiResponse.body}');
          // Clear user data from local storage
          await LocalStorageService.deleteData(
              key: StorageKeysConstants.userToken);
          await LocalStorageService.deleteData(
              key: StorageKeysConstants.userId);
          Get.find<UserController>().Token = '';
          Get.find<UserController>().currentUser.value = UserModel.empty();
        },
        onError: (errors, apiResponse) {
          log('Logout failed: ${errors.join(', ')}');
        },
      );

      return response?.statusCode == 200 ||
          response?.requestStatus == RequestStatus.success;
    } catch (e) {
      log('Error during logout: $e');
    }
    return false;
  }

  static Future<bool> ckeckToken(String token) async {
    try {
      final response = await HttpClientService.sendRequest(
        endPoint: EndPointsConstants.checkToken,
        requestType: HttpRequestTypes.get,
        header: {
          'authorization': 'Bearer ' + token,
        },
        onSuccess: (apiResponse) async {
          log('Logout successful: ${apiResponse.body}');
        },
        onError: (errors, apiResponse) async {
          await LocalStorageService.deleteData(
              key: StorageKeysConstants.userToken);
          await LocalStorageService.deleteData(
              key: StorageKeysConstants.userId);
          Get.find<UserController>().Token = '';
          Get.find<UserController>().currentUser.value = UserModel.empty();

          log('Token expired: ${errors.join(', ')}');
        },
      );

      return response?.statusCode == 200 ||
          response?.requestStatus == RequestStatus.success;
    } catch (e) {
      log('Error during logout: $e');
    }
    return false;
  }
}
