import 'package:cars/app/core/styles/text_styles.dart';
import 'package:cars/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Text(
            'Quick Actions',
            style: TextStyles.titleMedium(context).copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 110.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            physics: const BouncingScrollPhysics(),
            children: [
              ActionCard(
                ontap: () {
                  Get.toNamed(Routes.FASTREQUEST);
                },
                title: 'Emergency',
                icon: Icons.emergency,
                color: Colors.redAccent,
              ),
              ActionCard(
                title: 'Repair',
                ontap: () {},
                icon: Icons.build_rounded,
                color: Colors.blueAccent,
              ),
              ActionCard(
                ontap: () {},
                title: 'Towing',
                icon: Icons.car_repair,
                color: Colors.orangeAccent,
              ),
              ActionCard(
                ontap: () {},
                title: 'Service',
                icon: Icons.miscellaneous_services,
                color: Colors.purpleAccent,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ActionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback ontap;

  const ActionCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.ontap,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: 90.w,
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(icon, color: color, size: 28.sp),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
