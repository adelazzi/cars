import 'package:get/get.dart';
import 'package:cars/app/models/frombackend/ordermodel.dart';
import 'dart:developer';

class OrderdetailsController extends GetxController {
  final Rx<OrderModel?> order = Rx<OrderModel?>(null);
  final RxBool isLoading = true.obs;
  final RxBool isProcessing = false.obs;

  @override
  void onInit() async {
    super.onInit();
    final int orderId = Get.arguments['orderId'] ?? -1;
    log('order id ' + orderId.toString());

    if (orderId != -1) {
      fetchOrderDetails(orderId);
    } else {
      isLoading.value = false;
    }
  }

  Future<void> fetchOrderDetails(int orderId) async {
    try {
      isLoading.value = true;
      final orderData = await OrderModel.getOrderDetails(orderId);
      order.value = orderData;
    } catch (e) {
      log('Error fetching order details: $e');
      Get.snackbar('Error', 'Failed to load order details');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> markOrderAsPaid(int orderId) async {
    try {
      isProcessing.value = true;
      // Create updated order with completed status
      final updatedOrder = OrderModel(
        id: orderId,
        clientId: order.value!.clientId,
        totalPrice: order.value!.totalPrice,
        status: OrderStatus.completed,
        createdAt: order.value!.createdAt,
        updatedAt: DateTime.now(),
        storeId: order.value!.storeId,
        productId: order.value!.productId,
        productName: order.value!.productName,
        description: order.value!.description,
        notes: order.value!.notes,
      );

      await OrderModel.updateOrder(orderId, updatedOrder);
      order.value = updatedOrder;
      Get.snackbar('Success', 'Order marked as paid');
    } catch (e) {
      log('Error updating order: $e');
      Get.snackbar('Error', 'Failed to update order status');
    } finally {
      isProcessing.value = false;
    }
  }

  Future<void> refuseOrder(int orderId) async {
    try {
      isProcessing.value = true;
      // Create updated order with cancelled status
      final updatedOrder = OrderModel(
        id: orderId,
        clientId: order.value!.clientId,
        totalPrice: order.value!.totalPrice,
        status: OrderStatus.cancelled,
        createdAt: order.value!.createdAt,
        updatedAt: DateTime.now(),
        storeId: order.value!.storeId,
        productId: order.value!.productId,
        productName: order.value!.productName,
        description: order.value!.description,
        notes: order.value!.notes,
      );

      await OrderModel.updateOrder(orderId, updatedOrder);
      order.value = updatedOrder;
      Get.snackbar('Success', 'Order has been refused');
    } catch (e) {
      log('Error refusing order: $e');
      Get.snackbar('Error', 'Failed to refuse order');
    } finally {
      isProcessing.value = false;
    }
  }
}
