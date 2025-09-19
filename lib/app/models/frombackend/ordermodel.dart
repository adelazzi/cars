import 'dart:developer';

import 'package:cars/app/core/constants/end_points_constants.dart';
import 'package:cars/app/core/services/http_client_service.dart';
import 'package:cars/app/models/frombackend/usermodel.dart';
import 'package:cars/app/models/pagination_model.dart';
import 'package:cars/app/modules/user_controller.dart';
import 'package:get/get.dart';

class OrderModel {
  final int id;
  final int clientId;
  final int? storeId;
  final String? storeName;
  final String? firstName;
  final String? lastName;
  final int? productId;
  final String? productName;
  final String? description;
  final String totalPrice;
  final String? notes;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderModel({
    required this.id,
    required this.clientId,
    this.storeId,
    this.storeName,
    this.firstName,
    this.lastName,
    this.productId,
    this.productName,
    this.description,
    required this.totalPrice,
    this.notes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      clientId: json['client_id'],
      storeId: json['store_id'],
      storeName: json['store_name'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      productId: json['product_id'],
      productName: json['product_name'],
      description: json['description'],
      totalPrice: json['total_price'],
      notes: json['notes'],
      status: OrderStatus.fromString(json['status']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'client_id': clientId,
      'store_id': storeId,
      'product_id': productId,
      'product_name': productName,
      'description': description,
      'total_price': totalPrice,
      'notes': notes,
      'status': status.displayName(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /////// API Methods ///////
  ///
  static Future<PaginationModel<OrderModel>> fetchAllOrders() async {
    UserType? userRole = Get.find<UserController>().currentUser.value.userType;
    String endpoint = '';
    if (userRole == UserType.client) {
      endpoint = EndPointsConstants.clientorders; // No trailing slash
    } else if (userRole == UserType.store) {
      endpoint = EndPointsConstants.storeorders; // No trailing slash
    }
    log('Fetching orders from endpoint: $endpoint');
    log(Get.find<UserController>().Token);
    final response = await HttpClientService.sendRequest(
      header: {
        'Authorization': 'Bearer ${Get.find<UserController>().Token}',
      },
      endPoint: endpoint,
      requestType: HttpRequestTypes.get,
      onError: (errors, response) {
        log('Failed to fetch orders: ${response.body}');
      },
    );

    if (response != null && response.body is Map<String, dynamic>) {
      return PaginationModel<OrderModel>.fromJson(
        response.body,
        (json) => OrderModel.fromJson(json),
      );
    } else {
      throw Exception('Unexpected response format');
    }
  }

  static Future<OrderModel> getOrderDetails(int id) async {
    final response = await HttpClientService.sendRequest(
      header: {
        'Authorization': 'Bearer ${Get.find<UserController>().Token}',
      },
      endPoint: EndPointsConstants.orderApi + '$id' + '/',
      requestType: HttpRequestTypes.get,
      onError: (errors, _) {
        throw Exception('Failed to fetch order details: ${errors.join(', ')}');
      },
    );
    log(response!.body.toString());
    if (response != null && response.body is Map<String, dynamic>) {
      return OrderModel.fromJson(response.body);
    } else {
      throw Exception('Unexpected response format');
    }
  }

  static Future<void> updateOrder(int id, OrderModel order) async {
    await HttpClientService.sendRequest(
      header: {
        'Authorization': 'Bearer ${Get.find<UserController>().Token}',
      },
      endPoint: EndPointsConstants.orderApi + '$id' + '/',
      requestType: HttpRequestTypes.patch,
      data: order.toJson(),
      onError: (errors, _) {
        throw Exception('Failed to update order: ${errors.join(', ')}');
      },
    );
  }

  static Future<void> deleteOrder(int id) async {
    await HttpClientService.sendRequest(
      endPoint: '/orders/$id',
      requestType: HttpRequestTypes.delete,
      onError: (errors, _) {
        throw Exception('Failed to delete order: ${errors.join(', ')}');
      },
    );
  }
}

enum OrderStatus {
  pending,
  lookingForStore,
  confirmed,
  completed,
  cancelled,
  ;

  String displayName() {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.lookingForStore:
        return 'Looking for Store';
      case OrderStatus.confirmed:
        return 'Confirmed';
      case OrderStatus.completed:
        return 'Completed';
      case OrderStatus.cancelled:
        return 'Cancelled';
    }
  }

  static OrderStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return OrderStatus.pending;
      case 'looking_for_store':
        return OrderStatus.lookingForStore;
      case 'confirmed':
        return OrderStatus.confirmed;
      case 'completed':
        return OrderStatus.completed;
      case 'cancelled':
        return OrderStatus.cancelled;
      default:
        throw ArgumentError('Unknown order status: $status');
    }
  }
}
