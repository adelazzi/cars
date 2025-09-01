import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountOptionSection extends StatelessWidget {
  final VoidCallback onPaymentMethods;
  final VoidCallback onSupport;
  final VoidCallback onAbout;
  final VoidCallback onLogout;

  const AccountOptionSection({
    Key? key,
    required this.onPaymentMethods,
    required this.onSupport,
    required this.onAbout,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300.h,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          AccountOptionItem(
            icon: Icons.payment,
            label: 'Payment Methods',
            onTap: onPaymentMethods,
          ),
          const Divider(height: 1),
          AccountOptionItem(
            icon: Icons.support_agent,
            label: 'Support',
            onTap: onSupport,
          ),
          const Divider(height: 1),
          AccountOptionItem(
            icon: Icons.info_outline,
            label: 'About App',
            onTap: onAbout,
          ),
          const Divider(height: 1),
          AccountOptionItem(
            icon: Icons.logout,
            label: 'Logout',
            onTap: onLogout,
            textColor: Colors.red,
          ),
        ],
      ),
    );
  }
}

class AccountOptionItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? textColor;

  const AccountOptionItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: textColor ?? MainColors.primaryColor,
        size: 24.sp,
      ),
      title: Text(
        label,
        style: TextStyles.bodyMedium(context).copyWith(color: textColor),
      ),
      trailing: Icon(Icons.chevron_right, size: 24.sp),
      onTap: onTap,
    );
  }
}
