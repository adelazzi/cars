// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
//here add  nesesary imports
import 'package:cars/app/modules/login/bindings/login_binding.dart';
import 'package:cars/app/modules/login/views/login_view.dart';
import 'package:cars/app/modules/register/bindings/register_binding.dart';
import 'package:cars/app/modules/register/views/register_view.dart';
import 'package:cars/app/modules/profile/bindings/profile_binding.dart';
import 'package:cars/app/modules/profile/views/profile_view.dart';
import 'package:cars/app/modules/editprofile/bindings/editprofile_binding.dart';
import 'package:cars/app/modules/editprofile/views/editprofile_view.dart';
import 'package:cars/app/modules/notifications/bindings/notifications_binding.dart';
import 'package:cars/app/modules/notifications/views/notifications_view.dart';
import 'package:cars/app/modules/storedetails/bindings/storedetails_binding.dart';
import 'package:cars/app/modules/storedetails/views/storedetails_view.dart';
import 'package:cars/app/modules/cart/bindings/cart_binding.dart';
import 'package:cars/app/modules/cart/views/cart_view.dart';
import 'package:cars/app/modules/mappage/bindings/mappage_binding.dart';
import 'package:cars/app/modules/mappage/views/mappage_view.dart';
import 'package:cars/app/modules/orders/bindings/orders_binding.dart';
import 'package:cars/app/modules/orders/views/orders_view.dart';
import 'package:cars/app/modules/productsetails/bindings/productsetails_binding.dart';
import 'package:cars/app/modules/productsetails/views/productsetails_view.dart';
import 'package:cars/app/modules/descover/bindings/descover_binding.dart';
import 'package:cars/app/modules/descover/views/descover_view.dart';
import 'package:cars/app/modules/splash/bindings/splash_binding.dart';
import 'package:cars/app/modules/splash/views/splash_view.dart';

import 'package:cars/app/modules/main/bindings/main_binding.dart';
import 'package:cars/app/modules/main/views/main_view.dart';
import 'package:cars/app/modules/home/bindings/home_binding.dart';
import 'package:cars/app/modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;
  static final routes = [
    // hereadd the new files like the others
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDITPROFILE,
      page: () => EditprofileView(),
      binding: EditprofileBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.STOREDETAILS,
      page: () => StoredetailsView(),
      binding: StoredetailsBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
    GetPage(
      name: _Paths.MAPPAGE,
      page: () => MappageView(),
      binding: MappageBinding(),
    ),
    GetPage(
      name: _Paths.ORDERS,
      page: () => OrdersView(),
      binding: OrdersBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTSETAILS,
      page: () => ProductsetailsView(),
      binding: ProductsetailsBinding(),
    ),
    GetPage(
      name: _Paths.DESCOVER,
      page: () => DescoverView(),
      binding: DescoverBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
