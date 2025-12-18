import 'dart:developer';

import 'package:cars/app/core/constants/end_points_constants.dart';
import 'package:cars/app/core/services/http_client_service.dart';
import 'package:cars/app/models/pagination_model.dart';
import 'package:cars/app/modules/user_controller.dart';
import 'package:get/get.dart';

class AdsModel {
  final int storeId;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdAt;

  AdsModel({
    required this.storeId,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
  });

  factory AdsModel.fromJson(Map<String, dynamic> json) {
    return AdsModel(
      storeId: json['store_id'],
      title: json['title'],
      description: json['description'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'store_id': storeId,
      'title': title,
      'description': description,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  /////// API Methods ///////

  static Future<PaginationModel<AdsModel>> fetchAll() async {
    try {
      final userController = Get.find<UserController>();
      final token = userController.Token;

      if (token == null || token.isEmpty) {
        throw Exception('Authentication token is missing');
      }

      final response = await HttpClientService.sendRequest(
        header: {
          'Authorization': 'Bearer $token',
        },
        endPoint: EndPointsConstants.adsApi,
        requestType: HttpRequestTypes.get,
        onError: (errors, responce) {
          log('error' + responce.body.toString());
        },
      );

      if (response != null && response.body is Map<String, dynamic>) {
        return PaginationModel<AdsModel>.fromJson(
          response.body,
          (json) => AdsModel.fromJson(json),
        );
      }
      throw Exception('Unexpected response format');
    } catch (e) {
      log('Failed to fetch ads: $e');
      rethrow;
    }
  }

  static Future<AdsModel> create(Map<String, dynamic> data) async {
    final response = await HttpClientService.sendRequest(
      endPoint: '/ads',
      requestType: HttpRequestTypes.post,
      data: data,
      onError: (errors, _) => throw Exception(errors.join(', ')),
    );

    if (response != null && response.body is Map<String, dynamic>) {
      return AdsModel.fromJson(response.body);
    }
    throw Exception('Failed to create ad');
  }

  static Future<AdsModel> update(int id, AdsModel adsModel) async {
    final response = await HttpClientService.sendRequest(
      endPoint: '/ads/$id',
      requestType: HttpRequestTypes.put,
      data: adsModel.toJson(),
      onError: (errors, _) => throw Exception(errors.join(', ')),
    );

    if (response != null && response.body is Map<String, dynamic>) {
      return AdsModel.fromJson(response.body);
    }
    throw Exception('Failed to update ad');
  }

  static Future<void> remove(int id) async {
    await HttpClientService.sendRequest(
      endPoint: '/ads/$id',
      requestType: HttpRequestTypes.delete,
      onError: (errors, _) => throw Exception(errors.join(', ')),
    );
  }
}
