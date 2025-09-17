import 'package:cars/app/core/constants/images_assets_constants.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:cars/app/models/frombackend/carmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarCard extends StatelessWidget {
  final Car car;
  final VoidCallback? ontap;
  const CarCard({Key? key, required this.car, this.ontap}) : super(key: key);

  // Get appropriate car image based on type
  String _getCarImagePath(CarType type) {
    switch (type) {
      case CarType.voiture:
        return ImagesAssetsConstants.voiture;
      case CarType.motos_scooters:
        return ImagesAssetsConstants.motos_scooters;
      case CarType.fourgon:
        return ImagesAssetsConstants.fourgon;
      case CarType.camion:
        return ImagesAssetsConstants.camion;
      case CarType.bus:
        return ImagesAssetsConstants.bus;
      case CarType.tracteur:
        return ImagesAssetsConstants.tracteur;
    }
  }

  // Get icon for transmission type
  IconData _getTransmissionIcon(Transmission transmission) {
    switch (transmission) {
      case Transmission.automatic:
        return Icons.autorenew;
      case Transmission.manual:
        return Icons.drive_eta;
      case Transmission.semiAuto:
        return Icons.compare_arrows;
    }
  }

  // Get icon for fuel type
  IconData _getFuelIcon(FuelType fuelType) {
    switch (fuelType) {
      case FuelType.electric:
        return Icons.electric_car;
      case FuelType.hybrid:
        return Icons.battery_charging_full;
      default:
        return Icons.local_gas_station;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: 200.w,
        margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: MainColors.primaryColor.withOpacity(0.07),
          boxShadow: [
            BoxShadow(
              color: MainColors.shadowColor(context)!,
              spreadRadius: 1.r,
              blurRadius: 6.r,
              offset: Offset(0, 3.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 110.h,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(_getCarImagePath(car.type)),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                color: MainColors.whiteColor,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(16.r)),
                color: MainColors.backgroundColor(context) ?? Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${car.mark} ${car.model} ',
                    style: TextStyles.bodyMedium(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: MainColors.primaryColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          size: 14.sp, color: MainColors.categoryColor),
                      SizedBox(width: 4.w),
                      Text('${car.year}', style: TextStyles.bodySmall(context)),
                      Spacer(),
                      Icon(Icons.speed,
                          size: 14.sp, color: MainColors.categoryColor),
                      SizedBox(width: 4.w),
                      Text(car.moteur.isEmpty ? 'N/A' : car.moteur,
                          style: TextStyles.bodySmall(context)),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(_getFuelIcon(car.energie),
                          size: 14.sp, color: MainColors.categoryColor),
                      SizedBox(width: 4.w),
                      Text(
                        car.energie.name.capitalize(),
                        style: TextStyles.bodySmall(context),
                      ),
                      Spacer(),
                      Icon(
                        _getTransmissionIcon(car.boiteVitesse),
                        size: 14.sp,
                        color: MainColors.categoryColor,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        car.boiteVitesse.name.capitalize(),
                        style: TextStyles.bodySmall(context),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: MainColors.primaryColor.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      car.type.displayName,
                      style: TextStyles.bodySmall(context).copyWith(
                        color: MainColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Extension to capitalize the first letter of strings
extension StringExtension on String {
  String capitalize() {
    return isEmpty ? '' : '${this[0].toUpperCase()}${substring(1)}';
  }
}
