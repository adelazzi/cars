import 'package:cars/app/core/services/http_client_service.dart';

class OrderModel {
  final int clientId;
  final int? storeId;
  final int? productId;
  final String? productName;
  final String? description;
  final double totalPrice;
  final String? notes;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderModel({
    required this.clientId,
    this.storeId,
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
      clientId: json['client_id'],
      storeId: json['store_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      description: json['description'],
      totalPrice: (json['total_price'] as num).toDouble(),
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



    /////// API Methods ///////
    static Future<List<OrderModel>> fetchAllOrders() async {
      final response = await HttpClientService.sendRequest(
        endPoint: '/orders',
        requestType: HttpRequestTypes.get,
        onError: (errors, _) {
          throw Exception('Failed to fetch orders: ${errors.join(', ')}');
        },
      );

      if (response != null && response.body is List) {
        return (response.body as List)
            .map((order) => OrderModel.fromJson(order))
            .toList();
      } else {
        throw Exception('Unexpected response format');
      }
    }

    static Future<OrderModel> getOrderDetails(int id) async {
      final response = await HttpClientService.sendRequest(
        endPoint: '/orders/$id',
        requestType: HttpRequestTypes.get,
        onError: (errors, _) {
          throw Exception('Failed to fetch order details: ${errors.join(', ')}');
        },
      );

      if (response != null && response.body is Map<String, dynamic>) {
        return OrderModel.fromJson(response.body);
      } else {
        throw Exception('Unexpected response format');
      }
    }

    static Future<void> updateOrder(int id, OrderModel order) async {
      await HttpClientService.sendRequest(
      endPoint: '/orders/$id',
      requestType: HttpRequestTypes.put,
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
