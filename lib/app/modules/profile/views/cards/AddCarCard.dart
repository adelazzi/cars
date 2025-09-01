



import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:flutter/material.dart';

class AddCarCard extends StatelessWidget {
  final VoidCallback onTap;

  const AddCarCard({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 180,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: MainColors.primaryColor.withOpacity(0.05),
          border: Border.all(
            color: MainColors.primaryColor,
            width: 1,
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add_circle_outline,
                color: MainColors.primaryColor, size: 32),
            SizedBox(height: 8),
            Text(
              'Add New Car',
              style: TextStyles.bodySmall(context)
                  .copyWith(color: MainColors.primaryColor),
            ),
          ],
        ),
      ),
    );
  }
}

