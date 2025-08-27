import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cars/app/core/styles/colors.dart';

class AnimatedDropdownIndicator extends StatelessWidget {
  final bool isOpen;
  final Color defaultColor;
  final double size;
  final Duration duration;

  const AnimatedDropdownIndicator({
    super.key,
    required this.isOpen,
    this.defaultColor = Colors.black,
    this.size = 24.0,
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  Widget build(BuildContext context) {
    final color = MainColors.textColor(context) ?? defaultColor;
    return AnimatedContainer(
      duration: duration,
      width: size.w,
      height: size.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isOpen ? color.withOpacity(0.1) : Colors.transparent,
      ),
      child: Center(
        child: AnimatedRotation(
          turns: isOpen ? 0.5 : 0,
          duration: duration,
          child: Icon(
            Icons.keyboard_arrow_down,
            color: color,
            size: size * 0.7,
          ),
        ),
      ),
    );
  }
}
