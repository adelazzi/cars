import 'package:cars/app/models/frombackend/usermodel.dart';
import 'package:cars/app/modules/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:cars/app/models/frombackend/ordermodel.dart';
import 'package:cars/app/modules/orderdetails/controllers/orderdetails_controller.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderdetailsView extends GetView<OrderdetailsController> {
  OrderdetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Order Details',
          style: TextStyles.titleSmall(context)
              .copyWith(color: MainColors.primaryColor),
        ),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.order.value == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 60.r,
                  color: Colors.grey,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Order not found',
                  style: TextStyles.titleMedium(context),
                ),
              ],
            ),
          );
        }

        final order = controller.order.value!;
        UserType userrole =
            Get.find<UserController>().currentUser.value.userType;

        return Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatusCard(context, order),
                  SizedBox(height: 16.h),
                  _buildOrderDetails(context, order),
                  SizedBox(height: 16.h),

                  if (order.carId != null) ...[
                    _buildCarDetails(context, order),
                    SizedBox(height: 16.h),
                  ],
                  if (order.firstName != null && order.lastName != null) ...[
                    _buildStoreDetails(context, order),
                    SizedBox(height: 16.h),
                  ],

                  SizedBox(height: 80.h), // Space for action buttons
                ],
              ),
            ),
          ],
        );
      }),
      bottomSheet: Obx(
        () => controller.order.value?.status == OrderStatus.pending
            ? _buildActionButtons(context, controller.order.value!)
            : Container(
                decoration: BoxDecoration(
                  gradient: MainColors.primaryGradientColor,
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 1.r,
                      offset: Offset(0, -1),
                      color: MainColors.shadowColor(context)!,
                    )
                  ],
                ),
                height: 60.h,
                child: Center(
                  child: Text(
                    'thank for using our services',
                    style: TextStyles.bodyLarge(context).copyWith(
                      color: MainColors.backgroundColor(context),
                    ),
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildStatusCard(BuildContext context, OrderModel order) {
    Color statusColor;

    switch (order.status) {
      case OrderStatus.pending:
        statusColor = Colors.amber;
        break;
      case OrderStatus.lookingForStore:
        statusColor = Colors.blue;
        break;
      case OrderStatus.confirmed:
        statusColor = Colors.green;
        break;
      case OrderStatus.completed:
        statusColor = Colors.green.shade700;
        break;
      case OrderStatus.cancelled:
        statusColor = Colors.red;
        break;
    }

    return Container(
      margin: EdgeInsets.all(16.r),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        border: Border.all(width: 1.r, color: statusColor),
        borderRadius: BorderRadius.circular(12.r),
        // color: MainColors.backgroundColor(context),
        gradient: LinearGradient(
          colors: [
            statusColor.withOpacity(0.5),
            MainColors.backgroundColor(context)!
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(context)!,
            spreadRadius: 1.r,
            blurRadius: 5.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              _getStatusIcon(order.status),
              color: statusColor,
              size: 30.r,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order Status',
                  style: TextStyles.bodyMedium(context),
                ),
                SizedBox(height: 4.h),
                Text(
                  order.status.displayName(),
                  style: TextStyles.titleMedium(context).copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'DZD ${order.totalPrice}',
                  style: TextStyles.titleLarge(context).copyWith(
                    color: MainColors.backgroundColor(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetails(BuildContext context, OrderModel order) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MainColors.shadowColor(context)!, width: 1),
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(context)!,
            spreadRadius: 1.r,
            blurRadius: 5.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Order Information',
            style: TextStyles.titleMedium(context).copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            color: MainColors.primaryColor,
          ),
          _buildDetailRow(context, 'Product', order.productName ?? 'N/A'),
          if (order.quantity != null)
            _buildDetailRow(context, 'Quentity', order.quantity.toString()),
          if (order.description != null && order.description!.isNotEmpty)
            _buildDetailRow(context, 'Desqreption', order.description!),
          if (order.notes != null && order.notes!.isNotEmpty)
            _buildDetailRow(context, 'Notes', order.notes!),
        ],
      ),
    );
  }

  Widget _buildStoreDetails(BuildContext context, OrderModel order) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MainColors.shadowColor(context)!, width: 1),
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(context)!,
            spreadRadius: 1.r,
            blurRadius: 5.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            (order.storeName != null && order.storeName!.isNotEmpty)
                ? 'Store Information'
                : 'Client Information',
            style: TextStyles.titleMedium(context).copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            color: MainColors.primaryColor,
          ),
          if (order.storeName != null && order.storeName!.isNotEmpty)
            _buildDetailRow(context, 'Store name', order.storeName ?? 'N/A'),
          if (order.firstName != null && order.firstName!.isNotEmpty)
            _buildDetailRow(context, 'first name', order.firstName ?? 'N/A'),
          if (order.lastName != null && order.lastName!.isNotEmpty)
            _buildDetailRow(context, 'last name', order.lastName ?? 'N/A'),
          if (order.phoneNumber != null && order.phoneNumber!.isNotEmpty)
            if (order.phoneNumber != null && order.phoneNumber!.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Phone number',
                        style: TextStyles.bodyMedium(context).copyWith(
                          color: MainColors.primaryColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final Uri phoneUri = Uri(
                            scheme: 'tel',
                            path: order.phoneNumber,
                          );
                          if (await canLaunchUrl(phoneUri)) {
                            await launchUrl(phoneUri);
                          }
                        },
                        child: Text(
                          order.phoneNumber!,
                          style: TextStyles.bodyMedium(context).copyWith(
                            fontWeight: FontWeight.w500,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        ],
      ),
    );
  }

  Widget _buildCarDetails(BuildContext context, OrderModel order) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: MainColors.shadowColor(context)!, width: 1),
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(context)!,
            spreadRadius: 1.r,
            blurRadius: 5.r,
            offset: Offset(0, 3.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Car Information',
            style: TextStyles.titleMedium(context).copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            color: MainColors.primaryColor,
          ),
          _buildDetailRow(context, 'Car model', order.carModel.toString()),
          _buildDetailRow(context, 'Car mark', order.carMark.toString()),
          _buildDetailRow(
              context, 'Car carBoiteVitesse', order.carBoiteVitesse.toString()),
          _buildDetailRow(
              context, 'Car carEnergie', order.carEnergie.toString()),
          _buildDetailRow(context, 'Car Moteur', order.carMoteur.toString()),
          _buildDetailRow(context, 'Car Year', order.carYear.toString()),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyles.bodyMedium(context).copyWith(
                color: MainColors.primaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyles.bodyMedium(context).copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, OrderModel order) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(context)!.withOpacity(0.2),
            spreadRadius: 1.r,
            blurRadius: 10.r,
            offset: Offset(0, -3.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: controller.isProcessing.value
                  ? null
                  : () => controller.refuseOrder(order.clientId),
              style: ElevatedButton.styleFrom(
                backgroundColor: MainColors.whiteColor,
                foregroundColor: MainColors.logoutColor,
                side: BorderSide(color: MainColors.logoutColor, width: 1.r),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: Text(
                'Refuse',
                style: TextStyles.bodyMedium(context),
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: ElevatedButton(
              onPressed: controller.isProcessing.value
                  ? null
                  : () => controller.markOrderAsPaid(order.id),
              style: ElevatedButton.styleFrom(
                backgroundColor: MainColors.successColor(context),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: controller.isProcessing.value
                  ? SizedBox(
                      height: 20.h,
                      width: 20.w,
                      child: CircularProgressIndicator(
                        color: MainColors.whiteColor,
                        strokeWidth: 2.r,
                      ),
                    )
                  : Text(
                      'Mark as Paid',
                      style: TextStyles.bodyMedium(context).copyWith(
                        color: MainColors.whiteColor,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getStatusIcon(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Icons.pending_outlined;
      case OrderStatus.lookingForStore:
        return Icons.search;
      case OrderStatus.confirmed:
        return Icons.check_circle_outline;
      case OrderStatus.completed:
        return Icons.done_all;
      case OrderStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }
}
