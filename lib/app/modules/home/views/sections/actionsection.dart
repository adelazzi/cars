import 'package:cars/app/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            'Quick Actions',
            style: TextStyles.titleMedium(context).copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 90.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            children: [
              const ActionCard(
                  title: 'Search Parts',
                  icon: Icons.search,
                  color: Colors.blue),
              const ActionCard(
                  title: 'Categories',
                  icon: Icons.category,
                  color: Colors.orange),
              const ActionCard(
                  title: 'My Orders',
                  icon: Icons.shopping_bag,
                  color: Colors.green),
              const ActionCard(
                  title: 'Favorites', icon: Icons.favorite, color: Colors.red),
              const ActionCard(
                  title: 'Support',
                  icon: Icons.help_center,
                  color: Colors.purple),
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

  const ActionCard({
    Key? key,
    required this.title,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(icon, color: color, size: 24.sp),
          ),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
