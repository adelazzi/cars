class OrderModel {
  final String id;
  final String storeId;
  final String productId;
  final String storeName;
  final String productName;
  final OrderStatus status;
  final String destinationAddress;
  final String startAddress;
  final double prix;
  final double livreurPrix;
  final double totalPrix;
  final DateTime orderDate;
  final DateTime deliveryDate;
  final String customerId;
  final String customerName;
  final String paymentStatus;
  final String notes;
  final String orderType;
  final String trackingNumber;
  final double discount;

  OrderModel({
    required this.id,
    required this.storeId,
    required this.productId,
    required this.storeName,
    required this.productName,
    required this.status,
    required this.destinationAddress,
    required this.startAddress,
    required this.prix,
    required this.livreurPrix,
    required this.totalPrix,
    required this.orderDate,
    required this.deliveryDate,
    required this.customerId,
    required this.customerName,
    required this.paymentStatus,
    required this.notes,
    required this.orderType,
    required this.trackingNumber,
    required this.discount,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      storeId: json['storeId'],
      productId: json['productId'],
      storeName: json['storeName'],
      productName: json['productName'],
      status:  OrderStatus.fromString(json['status'])  ,
      destinationAddress: json['destinationAddress'],
      startAddress: json['startAddress'],
      prix: (json['prix'] as num).toDouble(),
      livreurPrix: (json['livreurPrix'] as num).toDouble(),
      totalPrix: (json['totalPrix'] as num).toDouble(),
      orderDate: DateTime.parse(json['orderDate']),
      deliveryDate: DateTime.parse(json['deliveryDate']),
      customerId: json['customerId'],
      customerName: json['customerName'],
      paymentStatus: json['paymentStatus'],
      notes: json['notes'],
      orderType: json['orderType'],
      trackingNumber: json['trackingNumber'],
      discount: (json['discount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'storeId': storeId,
      'productId': productId,
      'storeName': storeName,
      'productName': productName,
      'status': status.displayName(),
      'destinationAddress': destinationAddress,
      'startAddress': startAddress,
      'prix': prix,
      'livreurPrix': livreurPrix,
      'totalPrix': totalPrix,
      'orderDate': orderDate.toIso8601String(),
      'deliveryDate': deliveryDate.toIso8601String(),
      'customerId': customerId,
      'customerName': customerName,
      'paymentStatus': paymentStatus,
      'notes': notes,
      'orderType': orderType,
      'trackingNumber': trackingNumber,
      'discount': discount,
    };
  }
}

enum OrderStatus {
  pending,
  shipped,
  delivered,
  cancelled,
  refused,
  completed,
  ;

  String displayName() {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.shipped:
        return 'Shipped';
      case OrderStatus.delivered:
        return 'Delivered';
      case OrderStatus.cancelled:
        return 'Cancelled';
      case OrderStatus.refused:
        return 'Refused';
      case OrderStatus.completed:
        return 'Completed';
    }
  }

static OrderStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return OrderStatus.pending;
      case 'shipped':
        return OrderStatus.shipped;
      case 'delivered':
        return OrderStatus.delivered;
      case 'cancelled':
        return OrderStatus.cancelled;
      case 'refused':
        return OrderStatus.refused;
      case 'completed':
        return OrderStatus.completed;
      default:
        throw ArgumentError('Unknown order status: $status');
    }
  }

}

enum Ordertype {
  delivary,
  handtohand,
  ;

  String displayName() {
    switch (this) {
     case Ordertype.delivary:
        return 'Delivary';
      case Ordertype.handtohand:
        return 'Hand to hand';
    }
  }

  static Ordertype fromString(String type) {
    switch (type.toLowerCase()) {
      case 'delivary':
        return Ordertype.delivary;
      case 'handtohand':
        return Ordertype.handtohand;
      default:
        throw ArgumentError('Unknown order type: $type');
    }
  }


}