import 'package:cars/app/core/components/others/titelsection.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:cars/app/modules/explore/views/screens/hotedealssection.dart';
import 'package:cars/app/modules/home/views/sections/storessection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:cars/app/modules/explore/controllers/explore_controller.dart';

class ExploreView extends GetView<ExploreController> {
  ExploreView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              FeaturedProducts(
                title: '🔥 Hot Deals',
                subtitle: 'Limited time offers',
                onpressed: () {},
                featuredProducts: controller.featuredProducts,
              ),
              TitleSection(
                title: '🏪 Top Stores',
                subtitle: 'Trusted sellers',
                onpressed: () {},
              ),
              TopStores(
                topStores: controller.topStores,
              ),
              FeaturedProducts(
                title: 'electrical',
                subtitle: 'Limited time offers',
                onpressed: () {},
                featuredProducts: controller.Productscat1,
              ),
              FeaturedProducts(
                title: 'wheels',
                subtitle: 'Limited time offers',
                onpressed: () {},
                featuredProducts: controller.Productscat2,
              ),
             
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: MainColors.disableColor(Get.context!)!,
        ),
        color: MainColors.whiteColor,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(Get.context!)!.withOpacity(0.1),
            blurRadius: 10.r,
            offset: Offset(0, 2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search,
              color: MainColors.disableColor(Get.context!), size: 24.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              onChanged: (value) => controller.searchQuery.value = value,
              decoration: InputDecoration(
                fillColor: MainColors.backgroundColor(Get.context!),
                hintText: 'Search for car parts...',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: MainColors.textColor(Get.context!),
                ),
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: MainColors.primaryColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(Icons.tune, color: MainColors.whiteColor, size: 20.sp),
          ),
        ],
      ),
    );
  }
}
