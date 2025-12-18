import 'dart:developer';

import 'package:cars/app/models/frombackend/ordermodel.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  // Add your controller logic here
  final RxList<OrderModel> orders = <OrderModel>[].obs;

  void refresh() {
    fetchOrders();
    // orders.assignAll([
    //   OrderModel(
    //     clientId: 101,
    //     storeId: 1,
    //     productId: 1001,
    //     productName: 'Apples',
    //     description: 'Fresh red apples',
    //     totalPrice: 29.99,
    //     notes: 'Leave at the door',
    //     status: OrderStatus.pending,
    //     createdAt: DateTime.now().subtract(Duration(days: 1)),
    //     updatedAt: DateTime.now(),
    //   ),
    //   OrderModel(
    //     clientId: 102,
    //     storeId: 2,
    //     productId: 2001,
    //     productName: 'Headphones',
    //     description: 'Wireless noise-cancelling headphones',
    //     totalPrice: 79.50,
    //     notes: 'Signature required',
    //     status: OrderStatus.lookingForStore,
    //     createdAt: DateTime.now().subtract(Duration(days: 2)),
    //     updatedAt: DateTime.now(),
    //   ),
    //   OrderModel(
    //     clientId: 103,
    //     storeId: 3,
    //     productId: 3001,
    //     productName: 'Sourdough Loaf',
    //     description: 'Freshly baked sourdough bread',
    //     totalPrice: 4.99,
    //     notes: 'Call on arrival',
    //     status: OrderStatus.confirmed,
    //     createdAt: DateTime.now().subtract(Duration(days: 3)),
    //     updatedAt: DateTime.now().subtract(Duration(days: 2)),
    //   ),
    // ]);
  }

  Future<void> fetchOrders() async {
    try {
      final pagination = await OrderModel.fetchAllOrders();
      if (pagination != null) {
        orders.assignAll(pagination.results!);
      }
    } catch (e) {
      log('Error fetching orders: $e', name: 'OrdersController', error: e);
    }
  }




}
