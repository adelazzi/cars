import 'package:cars/app/models/ordermodel.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  // Add your controller logic here
  final RxList<OrderModel> orders = <OrderModel>[
  ].obs;



void refresh(){
  orders.assignAll([
        OrderModel(
          id: 'ord_1',
          storeId: 'store_1',
          productId: 'prod_1',
          storeName: 'Corner Shop',
          productName: 'Apples',
          status:OrderStatus.fromString('pending') ,
          destinationAddress: '123 Main St, Springfield',
          startAddress: 'Corner Shop, Market Rd',
          prix: 29.99,
          livreurPrix: 5.0,
          totalPrix: 34.99,
          orderDate: DateTime.now().subtract(Duration(days: 1)),
          deliveryDate: DateTime.now().add(Duration(hours: 2)),
          customerId: 'cust_1',
          customerName: 'Alice',
          paymentStatus: 'unpaid',
          notes: 'Leave at the door',
          orderType: 'delivery',
          trackingNumber: 'TRK-0001',
          discount: 0.0,
        ),
        OrderModel(
          id: 'ord_2',
          storeId: 'store_2',
          productId: 'prod_2',
          storeName: 'Electro Store',
          productName: 'Headphones',
          status: OrderStatus.fromString('pending') ,
          destinationAddress: '45 Elm St, Shelbyville',
          startAddress: 'Electro Store, High St',
          prix: 79.5,
          livreurPrix: 8.0,
          totalPrix: 87.5,
          orderDate: DateTime.now().subtract(Duration(days: 2)),
          deliveryDate: DateTime.now().add(Duration(days: 1)),
          customerId: 'cust_2',
          customerName: 'Bob',
          paymentStatus: 'paid',
          notes: 'Signature required',
          orderType: 'shipping',
          trackingNumber: 'TRK-0002',
          discount: 5.0,
        ),
        OrderModel(
          id: 'ord_3',
          storeId: 'store_3',
          productId: 'prod_3',
          storeName: 'Bakery',
          productName: 'Sourdough Loaf',
          status: OrderStatus.fromString('pending') ,
          destinationAddress: '9 Pine Ave, Ogden',
          startAddress: 'Bakery, Baker St',
          prix: 4.99,
          livreurPrix: 2.0,
          totalPrix: 6.99,
          orderDate: DateTime.now().subtract(Duration(days: 3)),
          deliveryDate: DateTime.now().subtract(Duration(days: 2, hours: 20)),
          customerId: 'cust_3',
          customerName: 'Charlie',
          paymentStatus: 'paid',
          notes: 'Call on arrival',
          orderType: 'pickup',
          trackingNumber: 'TRK-0003',
          discount: 0.5,
        ),
      ]);
  
}
 



}
