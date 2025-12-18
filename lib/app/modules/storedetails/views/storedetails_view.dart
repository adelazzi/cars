import 'package:cars/app/core/constants/images_assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cars/app/core/constants/strings_assets_constants.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:cars/app/modules/storedetails/controllers/storedetails_controller.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class StoredetailsView extends GetView<StoredetailsController> {
  const StoredetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return NestedScrollView(
          controller: controller.scrollController,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                expandedHeight: 220.0.h,
                floating: false,
                pinned: true,
                backgroundColor: MainColors.primaryColor,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Iconsax.arrow_left_2,
                      color: Colors.white, size: 24.sp),
                  onPressed: () => Get.back(),
                ),
                actions: [
                  Obx(() => IconButton(
                        icon: Icon(
                          controller.isFavorite.value
                              ? Iconsax.heart5
                              : Iconsax.heart,
                          color: controller.isFavorite.value
                              ? Colors.red
                              : Colors.white,
                          size: 24.sp,
                        ),
                        onPressed: controller.toggleFavorite,
                      )),
                  IconButton(
                    icon: Icon(Iconsax.share, color: Colors.white, size: 24.sp),
                    onPressed: () {},
                  ),
                ],
                title: Obx(() => AnimatedOpacity(
                      opacity: controller.showAppBarTitle.value ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Text(
                        controller.store.value.name ?? 'Store Details',
                        style: TextStyles.titleSmall(context).copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )),
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      controller.store.value.profileImage != null &&
                              controller.store.value.profileImage!.isNotEmpty
                          ? Image.network(
                              controller.store.value.profileImage!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  ImagesAssetsConstants.voiture,
                                  fit: BoxFit.cover,
                                );
                              },
                            )
                          : Image.asset(
                              ImagesAssetsConstants.voiture,
                              fit: BoxFit.cover,
                            ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.5),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ];
          },
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                // Store name and rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        controller.store.value.name ?? 'Store Name',
                        style: TextStyles.titleMedium(context).copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      child: Row(
                        children: [
                          Icon(Iconsax.star1, color: Colors.amber, size: 18.sp),
                          SizedBox(width: 4.w),
                          Text(
                            controller.store.value.rating.toStringAsFixed(1),
                            style: TextStyles.bodySmall(context).copyWith(
                              color: MainColors.textColor(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                // Location
                if (controller.store.value.address != null)
                  Row(
                    children: [
                      Icon(Iconsax.location, size: 16.sp, color: Colors.grey),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          '${controller.store.value.address}, ${controller.store.value.commune}, ${controller.store.value.wilaya}',
                          style: TextStyles.bodyMedium(context).copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                SizedBox(height: 24.h),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: Icon(Iconsax.call, size: 20.sp),
                        label: Text('Contact',
                            style: TextStyles.button(context)
                                .copyWith(color: MainColors.whiteColor)),
                        onPressed: controller.contactStore,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MainColors.primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: Icon(Iconsax.message, size: 20.sp),
                        label:
                            Text('review', style: TextStyles.button(context)),
                        onPressed: controller.addreview,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: MainColors.primaryColor,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          side: BorderSide(color: MainColors.primaryColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Verified badge and premium
                Row(
                  children: [
                    if (controller.store.value.verified)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Iconsax.verify,
                                size: 16.sp, color: Colors.green),
                            SizedBox(width: 4.w),
                            Text(
                              'Verified',
                              style: TextStyles.bodySmall(context).copyWith(
                                color: Colors.green,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    SizedBox(width: 8.w),
                    if (controller.store.value.premium)
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.amber.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: Colors.amber),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Iconsax.crown1,
                                size: 16.sp, color: Colors.amber),
                            SizedBox(width: 4.w),
                            Text(
                              'Premium',
                              style: TextStyles.bodySmall(context).copyWith(
                                color: Colors.amber[800],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Store information tabs
                DefaultTabController(
                  length: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TabBar(
                        labelColor: MainColors.primaryColor,
                        unselectedLabelColor: Colors.grey,
                        indicatorColor: MainColors.primaryColor,
                        labelStyle: TextStyles.bodyMedium(context).copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        unselectedLabelStyle: TextStyles.bodyMedium(context),
                        tabs: const [
                          Tab(text: 'About'),
                          // Tab(text: 'Services'),
                          Tab(text: 'Reviews'),
                        ],
                        onTap: (index) =>
                            controller.selectedTabIndex.value = index,
                      ),
                      SizedBox(height: 16.h),

                      // Tab content
                      Obx(() {
                        switch (controller.selectedTabIndex.value) {
                          case 0:
                            return _buildAboutTab();
                          // case 1:
                          //   return _buildServicesTab();
                          case 1:
                            return _buildReviewsTab();
                          default:
                            return _buildAboutTab();
                        }
                      }),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // Brands specialized in
                if (controller.store.value.brands != null &&
                    controller.store.value.brands!.isNotEmpty)
                  _buildSpecializedBrands(),

                SizedBox(height: 32.h),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAboutTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyles.titleMedium(Get.context!).copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          controller.store.value.name != null
              ? 'Welcome to ${controller.store.value.name}! We specialize in automotive repair and maintenance services with a commitment to quality and customer satisfaction. Our team of skilled technicians is dedicated to providing the best service for your vehicle.'
              : 'Store description not available',
          style: TextStyles.bodyMedium(Get.context!),
        ),
        SizedBox(height: 16.h),

        // Working Hours
        Text(
          'Weekend',
          style: TextStyles.titleSmall(Get.context!).copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        _buildWorkingHours(),

        SizedBox(height: 16.h),

        // Contact Information
        Text(
          'Contact Information',
          style: TextStyles.titleSmall(Get.context!).copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        if (controller.store.value.phoneNumber != null)
          _buildInfoRow(Iconsax.call, controller.store.value.phoneNumber!),
        if (controller.store.value.email != null)
          _buildInfoRow(Iconsax.sms, controller.store.value.email!),
      ],
    );
  }

  Widget _buildServicesTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our Services',
          style: TextStyles.titleMedium(Get.context!).copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.storeServices.length,
          itemBuilder: (context, index) {
            final service = controller.storeServices[index];
            return Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side: BorderSide(color: Colors.grey.withOpacity(0.2)),
              ),
              margin: EdgeInsets.only(bottom: 8.h),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                leading: CircleAvatar(
                  backgroundColor: MainColors.primaryColor.withOpacity(0.1),
                  radius: 20.r,
                  child: Icon(
                    Iconsax.setting_4,
                    color: MainColors.primaryColor,
                    size: 20.sp,
                  ),
                ),
                title: Text(
                  service,
                  style: TextStyles.bodyLarge(Get.context!).copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Icon(
                  Iconsax.arrow_right_3,
                  size: 16.sp,
                  color: MainColors.primaryColor,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildReviewsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Customer Reviews',
              style: TextStyles.titleMedium(Get.context!).copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            RatingBar.builder(
              initialRating: controller.store.value.rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 18.sp,
              ignoreGestures: true,
              itemBuilder: (context, _) => Icon(
                Iconsax.star1,
                color: Colors.amber,
                size: 18.sp,
              ),
              onRatingUpdate: (_) {},
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          '${controller.store.value.rating.toStringAsFixed(1)} out of 5',
          style: TextStyles.bodyMedium(Get.context!),
        ),
        SizedBox(height: 16.h),

        // Sample reviews - replace with actual reviews from backend
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return _buildReviewItem(index);
          },
        ),

        SizedBox(height: 16.h),
        Center(
          child: TextButton(
            onPressed: () {
              // Navigate to all reviews
            },
            child: Text(
              'See all reviews',
              style: TextStyles.bodyMedium(Get.context!).copyWith(
                color: MainColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpecializedBrands() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Specialized In',
          style: TextStyles.titleMedium(Get.context!).copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 80.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.store.value.brands?.length ?? 0,
            itemBuilder: (context, index) {
              final brand = controller.store.value.brands![index];
              return Container(
                width: 100.w,
                margin: EdgeInsets.only(right: 12.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.grey.withOpacity(0.2)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (brand.image.isNotEmpty)
                      SizedBox(
                        height: 40.h,
                        child: Image.network(
                          brand.image,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Iconsax.car, size: 40.sp),
                        ),
                      ),
                    SizedBox(height: 4.h),
                    Text(
                      brand.name,
                      style: TextStyles.bodySmall(Get.context!),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWorkingHours() {
    final weekendDay = controller.store.value.weekend ?? 'Friday';

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: MainColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Iconsax.calendar,
              color: MainColors.primaryColor,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Weekend',
                style: TextStyles.bodySmall(Get.context!).copyWith(
                  color: Colors.grey,
                ),
              ),
              Text(
                '$weekendDay: Closed',
                style: TextStyles.bodyMedium(Get.context!).copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: Colors.grey),
          SizedBox(width: 8.w),
          Text(
            text,
            style: TextStyles.bodyMedium(Get.context!),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem(int index) {
    // Sample data - replace with actual reviews
    final names = ['John Smith', 'Sarah Wilson', 'Michael Brown'];
    final ratings = [4.5, 5.0, 3.5];
    final comments = [
      'Great service! They fixed my car quickly and for a reasonable price.',
      'Best automotive shop in town. Very professional and knowledgeable staff.',
      'Good service but took longer than expected. Otherwise satisfied with the repairs.'
    ];
    final dates = ['Sep 15, 2025', 'Sep 10, 2025', 'Sep 5, 2025'];

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(0.2),
                radius: 20.r,
                child: Text(
                  names[index][0],
                  style: TextStyles.bodyLarge(Get.context!).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      names[index],
                      style: TextStyles.bodyMedium(Get.context!).copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Row(
                      children: [
                        RatingBar.builder(
                          initialRating: ratings[index],
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemSize: 14.sp,
                          ignoreGestures: true,
                          itemBuilder: (context, _) => Icon(
                            Iconsax.star1,
                            color: Colors.amber,
                            size: 14.sp,
                          ),
                          onRatingUpdate: (_) {},
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          dates[index],
                          style: TextStyles.bodySmall(Get.context!).copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            comments[index],
            style: TextStyles.bodyMedium(Get.context!),
          ),
          Divider(height: 32.h),
        ],
      ),
    );
  }
}
