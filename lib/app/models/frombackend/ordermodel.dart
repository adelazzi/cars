import 'dart:developer';

import 'package:cars/app/core/constants/end_points_constants.dart';
import 'package:cars/app/core/services/http_client_service.dart';
import 'package:cars/app/models/frombackend/usermodel.dart';
import 'package:cars/app/models/pagination_model.dart';
import 'package:cars/app/modules/orders/controllers/orders_controller.dart';
import 'package:cars/app/modules/user_controller.dart';
import 'package:get/get.dart';

class OrderModel {
  final int id;
  final int clientId;
  final int? storeId;
  final String? storeName;
  final String? firstName;
  final String? lastName;
  final String? phoneNumber;
  final int? productId;
  final String? productName;
  final String? productImageUrl;
  final String? description;
  final String totalPrice;
  final String? notes;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int? carId;
  final String? carModel;
  final int? carYear;
  final String? carMark;
  final String? carEnergie;
  final String? carBoiteVitesse;
  final String? carMoteur;
  final int? quantity;

  OrderModel({
    this.quantity,
    required this.id,
    required this.clientId,
    this.storeId,
    this.storeName,
    this.firstName,
    this.lastName,
    this.phoneNumber,
    this.productId,
    this.productName,
    this.productImageUrl,
    this.description,
    required this.totalPrice,
    this.notes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.carId,
    this.carModel,
    this.carYear,
    this.carMark,
    this.carEnergie,
    this.carBoiteVitesse,
    this.carMoteur,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      clientId: json['client_id'],
      storeId: json['store_id'],
      productId: json['product_id'],
      totalPrice: json['total_price'],
      notes: json['notes'],
      status: OrderStatus.fromString(json['status']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      carId: json['car_id'],

      // Handle car information if present
      carModel: json['car_model'],
      carYear: json['car_year'],
      carMark: json['car_mark'],
      carEnergie: json['car_energie'],
      carBoiteVitesse: json['car_boitevitesse'],
      carMoteur: json['car_moteur'],

      // Handle product information if present
      productName: json['product_name'],
      productImageUrl: json['product_image_url'],
      description: json['descreption'],
      quantity: json['quantity'],

      // Handle store or user information if present
      storeName: json['store_name'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      phoneNumber: json['phone_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // ids
      'client_id': clientId,
      'store_id': storeId,
      'product_id': productId,
      'car_id': carId,

      // product information
      'product_name': productName,
      'product_image_url': productImageUrl,
      'quantity': quantity,
      'descreption': description,

      // pricing and notes
      'total_price': totalPrice,
      'notes': notes,

      // status
      'status': status.name,
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
    log('Token :' + Get.find<UserController>().Token);
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
    log(' this is the endpoint :' + EndPointsConstants.orderApi + '$id' + '/');
    log('this is the Order :' + order.toJson().toString());

    await HttpClientService.sendRequest(
      header: {
        'Authorization': 'Bearer ${Get.find<UserController>().Token}',
      },
      endPoint: EndPointsConstants.orderApi + '$id' + '/',
      requestType: HttpRequestTypes.put,
      data: order.toJson(),
      onSuccess: (response) {
        Get.find<OrdersController>()
            .orders
            .where(
              (o) => o.id == id,
            )
            .forEach((o) {
          int index = Get.find<OrdersController>().orders.indexOf(o);
          if (index != -1) {
            Get.find<OrdersController>().orders[index] = order;
          }
        });
        Get.find<OrdersController>().update();
      },
      onError: (errors, responce) {
        log('this is the eroor' + responce.body.toString());
        log('Failed to update order: ${errors.join(', ')}');
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
