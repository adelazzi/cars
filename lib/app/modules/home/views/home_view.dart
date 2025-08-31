import 'package:cars/app/core/components/cards/carsbrandcomponent.dart';
import 'package:cars/app/core/components/cards/wilayacard.dart';
import 'package:cars/app/core/components/others/titelsection.dart';
import 'package:cars/app/core/constants/wilayas.dart';
import 'package:cars/app/models/CarsBrandmodel.dart';
import 'package:cars/app/modules/home/views/sections/storessection.dart';
import 'package:cars/app/modules/home/views/sections/actionsection.dart';
import 'package:cars/app/modules/home/views/sections/bannersection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cars/app/core/constants/strings_assets_constants.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:cars/app/modules/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'AutoParts',
          style: TextStyles.titleSmall(context).copyWith(
            color: MainColors.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined,
                color: MainColors.primaryColor),
            onPressed: () {},
          ),
          
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.refresh();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Section
                ModernBannerSection(),

                SizedBox(height: 12.h),

                // Quick Actions Section
                QuickActionsSection(),

                TitleSection(
                  title: '🏪 Top Stores',
                  subtitle: 'Trusted sellers',
                  onpressed: () {},
                ),
                TopStores(
                  topStores: controller.topStores,
                ),
                SizedBox(height: 12.h),

                // Wilaya Section
                _buildWilayaSection(context),

                SizedBox(height: 32.h),

                // Car Brands Section
                _buildCarBrandsSection(context),

                _buildSectionTitle(
                  title: '💡 Why Choose Us?',
                  subtitle: '',
                  onpressed: () {},
                ),
                _buildFeatures(),
                SizedBox(height: 32.h),

                // Support Store Section
                _buildSupportStoreSection(context),

                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(
      {required String title,
      required String subtitle,
      VoidCallback? onpressed}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.labelMedium(Get.context!).copyWith(
                  fontWeight: FontWeight.bold,
                  color: MainColors.textColor(Get.context!),
                ),
              ),
              if (subtitle.isNotEmpty)
                Text(
                  subtitle,
                  style: TextStyles.bodySmall(Get.context!).copyWith(
                    color: MainColors.textColor(Get.context!)?.withOpacity(0.6),
                  ),
                ),
            ],
          ),
          TextButton(
            onPressed: onpressed,
            child: Text(
              'See All',
              style: TextStyles.bodyMedium(Get.context!).copyWith(
                color: MainColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWilayaSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          title: 'Wilayas',
          subtitle: '',
          onpressed: () {
            // Handle "View All" action
          },
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: WilayasData.allWilayas
                .map((wilaya) {
                  return wilayacard(wilaya: wilaya);
                })
                .toList()
                .sublist(1, 9),
          ),
        ),
      ],
    );
  }

  Widget _buildCarBrandsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle(
          title: 'Car Brands',
          subtitle: '',
          onpressed: () {
            // Handle "View All" action
          },
        ),
        SizedBox(
          height: 140.h, // Adjusted height for better layout
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: carBrandsList.length,
            itemBuilder: (context, index) {
              final car = carBrandsList[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: CarsBrandComponent(
                  brandName: car.name ?? '',
                  logoUrl: car.image ?? '',
                  isPremium: [
                    'Ferrari',
                    'Lamborghini',
                    'Tesla',
                    'BMW',
                    'Mercedes-Benz'
                  ].contains(car.name), // Example premium brands
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSupportStoreSection(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Material(
        elevation: 4,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                MainColors.primaryColor,
                MainColors.primaryColor.withOpacity(0.8),
              ],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Need Help?',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Contact our support team for expert assistance',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: MainColors.primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.support_agent, size: 18),
                                const SizedBox(width: 8),
                                Text('Contact Support'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.headset_mic,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatures() {
    final features = [
      {
        'icon': '🚚',
        'title': 'Free Shipping',
        'subtitle': 'On orders over \$100'
      },
      {
        'icon': '🔄',
        'title': 'Easy Returns',
        'subtitle': '30-day return policy'
      },
      {'icon': '🛡️', 'title': 'Warranty', 'subtitle': '1-year guarantee'},
      {'icon': '📞', 'title': '24/7 Support', 'subtitle': 'Expert assistance'},
    ];

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.6,
        ),
        itemCount: features.length,
        itemBuilder: (context, index) {
          final feature = features[index];
          return Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: MainColors.shadowColor(context)!.withOpacity(0.2),
                  blurRadius: 2,
                  offset: Offset(0, 3),
                )
              ],
              gradient: MainColors.primaryGradientColor,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  feature['title']!,
                  style: TextStyles.bodyMedium(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  feature['subtitle']!,
                  style: TextStyles.bodySmall(context).copyWith(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
