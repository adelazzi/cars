import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:cars/app/models/carmodel.dart';
import 'package:cars/app/modules/profile/views/cards/AddCarCard.dart';
import 'package:cars/app/modules/profile/views/cards/CarCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class MyCarsSection extends StatelessWidget {
  final RxList<Car> cars;
  final VoidCallback onSeeAll;
  final VoidCallback onAddCar;
  final void Function(int) onCarTap;

  const MyCarsSection({
    Key? key,
    required this.cars,
    required this.onSeeAll,
    required this.onAddCar,
    required this.onCarTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: 340.h,
          margin: EdgeInsets.symmetric(horizontal: 16.h, vertical: 8.h),
          decoration: BoxDecoration(
            color: MainColors.backgroundColor(context),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('My Cars', style: TextStyles.titleSmall(context)),
                    TextButton(
                      onPressed: onSeeAll,
                      child: Text(
                        'See all',
                        style: TextStyles.labelSmall(context)
                            .copyWith(color: MainColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 240.h,
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  scrollDirection: Axis.horizontal,
                  itemCount: cars.value.length + 1,
                  itemBuilder: (context, index) {
                    if (index == cars.value.length) {
                      return AddCarCard(onTap: onAddCar);
                    }
                    return CarCard(
                      ontap: () => onCarTap(index),
                      car: cars[index],
                    );
                  },
                ),
              ),
              //    SizedBox(height: 16),
            ],
          ),
        ));
  }
}
