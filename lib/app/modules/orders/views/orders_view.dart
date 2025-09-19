import 'package:cars/app/core/components/cards/ordertile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cars/app/core/constants/strings_assets_constants.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:cars/app/modules/orders/controllers/orders_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            ' My orders ',
            style: TextStyles.titleMedium(context)
                .copyWith(color: MainColors.primaryColor),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh, color: MainColors.primaryColor),
              onPressed: () {
                controller.refresh();
              },
            ),
          ],
        ),
        body: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                  itemCount: controller.orders.value.length,
                  itemBuilder: (context, index) {
                    return OrderTile(order: controller.orders.value[index]);
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0.w),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(12.0.r),
        boxShadow: [
          BoxShadow(
            color: MainColors.primaryColor.withOpacity(0.4),
            blurRadius: 3.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildInfoColumn(context, controller.orders.value.length.toString(),
                "Total Orders", MainColors.primaryColor),
            _buildInfoColumn(
                context,
                controller.orders.value
                    .where((order) => order.status.displayName() == 'Completed')
                    .length
                    .toString(),
                "Completed",
                MainColors.successColor(context)!),
            _buildInfoColumn(
                context,
                controller.orders.value
                    .where((order) => order.status.displayName() == 'Pending')
                    .length
                    .toString(),
                "Pending",
                MainColors.warningColor(context)!),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoColumn(
      BuildContext context, String value, String title, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyles.titleMedium(context).copyWith(
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyles.bodySmall(context).copyWith(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
