// modern_banner_section.dart
import 'package:cars/app/core/components/cards/ModernBannerCard.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../controllers/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ModernBannerSection extends StatelessWidget {
  const ModernBannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Container(
      width: double.infinity,
      height: 250.h, // Use ScreenUtil for responsive height
      child: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            children: [
              ModernBannerCard(
                imagePath: 'assets/images/banner1.jpg',
                title: 'Premium Car Parts',
                subtitle: 'Get 20% OFF on all genuine parts',
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                ),
                icon: Icons.build_circle_outlined,
                bannerType: 'parts',
                controller: controller,
              ),
              ModernBannerCard(
                imagePath: 'assets/images/banner2.jpg',
                title: 'Fast Delivery',
                subtitle: 'Same day delivery available',
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFDC2626), Color(0xFFEF4444)],
                ),
                icon: Icons.local_shipping_outlined,
                bannerType: 'delivery',
                controller: controller,
              ),
              ModernBannerCard(
                imagePath: 'assets/images/banner3.jpg',
                title: 'Expert Service',
                subtitle: 'Professional installation support',
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF059669), Color(0xFF10B981)],
                ),
                icon: Icons.support_agent_outlined,
                bannerType: 'service',
                controller: controller,
              ),
            ],
          ),
          Positioned(
            bottom: 5.h, // Use ScreenUtil for responsive positioning
            child: SmoothPageIndicator(
              controller: controller.pageController,
              count: 3,
              effect: WormEffect(
                dotHeight: 4.w,
                dotWidth: 15.w,
                spacing: 9.w,
                dotColor: Colors.black.withOpacity(0.3),
                activeDotColor: MainColors.primaryColor,
                type: WormType.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
