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
          Obx(
            () => PageView.builder(
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              itemCount: controller.ads.length,
              itemBuilder: (context, index) {
                final ad = controller.ads[index];
                return ModernBannerCard(
                  ad: ad,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6)],
                  ),
                  controller: controller,
                );
              },
            ),
          ),
          Positioned(
            bottom: 5.h, // Use ScreenUtil for responsive positioning
            child: Obx(
              () => controller.ads.isNotEmpty
                  ? SmoothPageIndicator(
                      controller: controller.pageController,
                      count: controller.ads.length,
                      effect: WormEffect(
                        dotHeight: 4.w,
                        dotWidth: 15.w,
                        spacing: 9.w,
                        dotColor: Colors.black.withOpacity(0.3),
                        activeDotColor: MainColors.primaryColor,
                        type: WormType.normal,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
