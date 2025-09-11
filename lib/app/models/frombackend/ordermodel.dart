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
      clientId: json['clientId'],
      storeId: json['storeId'],
      productId: json['productId'],
      productName: json['productName'],
      description: json['description'],
      totalPrice: (json['totalPrice'] as num).toDouble(),
      notes: json['notes'],
      status: OrderStatus.fromString(json['status']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'clientId': clientId,
      'storeId': storeId,
      'productId': productId,
      'productName': productName,
      'description': description,
      'totalPrice': totalPrice,
      'notes': notes,
      'status': status.displayName(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
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
}
