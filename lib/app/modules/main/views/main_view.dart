import 'package:cars/app/modules/explore/views/explore_view.dart';
import 'package:cars/app/modules/home/views/home_view.dart';
import 'package:cars/app/modules/orders/views/orders_view.dart';
import 'package:cars/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/modules/main/controllers/main_controller.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class MainView extends GetView<MainController> {
  MainView({Key? key}) : super(key: key);

  final List<Widget> screens = [
    HomeView(),
    ExploreView(),
    OrdersView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => screens[controller.selectedIndex.value]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: MainColors.primaryGradientColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
          boxShadow: [
            BoxShadow(
              color: MainColors.textColor(context)!,
              blurRadius: 5.r,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.r),
            topRight: Radius.circular(25.r),
          ),
          child: Obx(() => BottomNavigationBar(
                currentIndex: controller.selectedIndex.value,
                onTap: controller.changeIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                elevation: 0,
                selectedItemColor: MainColors.whiteColor,
                unselectedItemColor: MainColors.whiteColor.withOpacity(0.6),
                selectedFontSize: 12.sp,
                unselectedFontSize: 10.sp,
                items: [
                  BottomNavigationBarItem(
                    icon: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == 0
                            ? MainColors.whiteColor.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.home_rounded, size: 24.sp),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == 1
                            ? MainColors.whiteColor.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.explore_rounded, size: 24.sp),
                    ),
                    label: 'Explore',
                  ),
                  BottomNavigationBarItem(
                    icon: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == 2
                            ? MainColors.whiteColor.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.favorite_rounded, size: 24.sp),
                    ),
                    label: 'Favorites',
                  ),
                  BottomNavigationBarItem(
                    icon: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: controller.selectedIndex.value == 3
                            ? MainColors.whiteColor.withOpacity(0.2)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.person_rounded, size: 24.sp),
                    ),
                    label: 'Profile',
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
