import 'package:cars/app/core/constants/icons_assets_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../models/frombackend/ordermodel.dart';
import '../../styles/colors.dart';
import '../../styles/text_styles.dart';
class OrderTile extends StatelessWidget {
  final OrderModel order;

  const OrderTile({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat.yMMMd().format(order.createdAt);
    final currencyFormat =
        NumberFormat.currency(locale: 'en_US', symbol: 'DZD');

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: order.status == OrderStatus.completed
              ? MainColors.successColor(context)!
              : order.status == OrderStatus.cancelled
                  ? MainColors.errorColor(context)!
                  : MainColors.warningColor(context)!,
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: MainColors.textColor(context)!.withOpacity(0.1),
            blurRadius: 6.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 15.r),
            child: SvgPicture.asset(
              IconsAssetsConstants.order_pending,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                order.productName ?? 'No Product',
                style: TextStyles.labelSmall(context),
              ),
              Text(
                formattedDate,
                style: TextStyles.bodySmall(context),
              ),
              Text(
                currencyFormat.format(order.totalPrice),
                style: TextStyles.bodyMedium(context).copyWith(
                  color: MainColors.primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 6.r, horizontal: 12.r),
              decoration: BoxDecoration(
                color: order.status == OrderStatus.completed
                    ? MainColors.successColor(context)!
                    : order.status == OrderStatus.cancelled
                        ? MainColors.errorColor(context)!
                        : MainColors.warningColor(context)!,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(12.r),
                  topRight: Radius.circular(12.r),
                ),
              ),
              child: Text(
                order.status.displayName(),
                style: TextStyles.bodySmall(context).copyWith(
                  color: MainColors.backgroundColor(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
