// ignore_for_file: deprecated_member_use, unnecessary_null_in_if_null_operators, must_be_immutable

import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PrimaryButtonComponent extends StatelessWidget {
  PrimaryButtonComponent(
      {Key? key,
      required this.onTap,
      required this.text,
      this.backgroundColor,
      this.textColor,
      this.borderColor,
      this.gradient,
      this.borderRadius,
      this.width,
      this.height,
      this.isLoading,
      this.fontWeight,
      this.fontFamily,
      this.iconLink,
      this.AlignmentRow,
      this.fontSize,
      this.isEnabled,
      this.leftDotColor,
      this.rightDotColor,
      this.boxShadow,
      this.disableShadow})
      : super(key: key);

  @required
  final Function onTap;
  final String text;
  final Color? backgroundColor;
  final Gradient? gradient;
  final Color? textColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  double? fontSize;
  final bool? isLoading;
  final bool? disableShadow, isEnabled;
  FontWeight? fontWeight;
  String? fontFamily;
  String? iconLink;
  Color? leftDotColor, rightDotColor;
  MainAxisAlignment? AlignmentRow;
  BoxShadow? boxShadow;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        gradient: backgroundColor == null
            ? gradient ?? MainColors.primaryGradientColor
            : null,
        color: backgroundColor,
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: 0.5,
        ),
        borderRadius: borderRadius ?? BorderRadius.circular(1000.r),
        boxShadow: disableShadow != false
            ? [
                boxShadow ??
                    BoxShadow(
                      color: (MainColors.primaryColor.withOpacity(0.2)),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: Offset(0, 10.h),
                    ),
              ]
            : null,
      ),
      child: isEnabled == false
          ? Container(
              height: 55.h,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLoading == false || isLoading == null)
                    Expanded(
                      child: Center(
                          child: Row(
                        textBaseline: TextBaseline.ideographic,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment:
                            AlignmentRow ?? MainAxisAlignment.center,
                        children: [
                          // Align(
                          //   alignment: Alignment.center,
                          //   child:
                          Text(
                            text,
                            style: TextStyles.labelMedium(context).copyWith(
                              color: textColor ??
                                  MainColors.whiteColor.withOpacity(0.7),
                              fontSize: 18.sp,
                              fontWeight: fontWeight ?? null,
                              fontFamily: fontFamily ?? null,
                              // ),
                            ),
                          ),

                          if (iconLink != null)
                            Row(
                              children: [
                                SizedBox(
                                  width: 10.r,
                                ),
                                Get.locale?.languageCode == "ar"
                                    ? SvgPicture.asset(
                                        iconLink ?? "",
                                        color: MainColors.whiteColor,
                                        width: 25.r,
                                        height: 20.r,
                                      )
                                    : RotatedBox(
                                        quarterTurns:
                                            2, // يمكن تعيين قيمة تدوير 1 أو 3 حسب الحاجة
                                        child: SvgPicture.asset(
                                          iconLink ?? "",
                                          color: MainColors.whiteColor,
                                          width: 25.r,
                                          height: 20.r,
                                        )),
                                Get.locale?.languageCode == "en"
                                    ? SizedBox(
                                        width: 120.r,
                                      )
                                    : SizedBox(
                                        width: 90.r,
                                      ),
                              ],
                            )
                        ],
                      )),
                    ),
                ],
              ),
            )
          : TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius:
                        borderRadius ?? BorderRadius.circular(1000.r)),
                backgroundColor: MainColors.transparentColor,
                foregroundColor: MainColors.transparentColor,
              ),
              onPressed: () => onTap(),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isLoading == true)
                    LoadingAnimationWidget.staggeredDotsWave(
                        color: Colors.white, size: 35.r),
                  if (isLoading == false || isLoading == null)
                    Expanded(
                      child: Center(
                          child: Row(
                        textBaseline: TextBaseline.ideographic,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment:
                            AlignmentRow ?? MainAxisAlignment.center,
                        children: [
                          // Align(
                          //   alignment: Alignment.center,
                          //   child:
                          Text(
                            text,
                            style: TextStyles.bodyLarge(context).copyWith(
                              color: textColor ?? MainColors.whiteColor,
                              fontSize: fontSize ?? 16.sp,
                              fontWeight: fontWeight ?? null,
                              fontFamily: fontFamily ?? null,
                              // ),
                            ),
                          ),

                          if (iconLink != null)
                            Row(
                              children: [
                                SizedBox(
                                  width: 10.r,
                                ),
                                Get.locale?.languageCode == "ar"
                                    ? SvgPicture.asset(
                                        iconLink ?? "",
                                        color: MainColors.whiteColor,
                                        width: 25.r,
                                        height: 25.r,
                                      )
                                    : RotatedBox(
                                        quarterTurns: 0,
                                        child: SvgPicture.asset(
                                          iconLink ?? "",
                                          color: MainColors.whiteColor,
                                          width: 25.r,
                                          height: 20.r,
                                        )),
                                // Get.locale?.languageCode == "en"
                                // ? SizedBox(
                                //     width: 120.r,
                                //   )
                                // : SizedBox(
                                //     width: 90.r,
                                //   ),
                              ],
                            )
                        ],
                      )),
                    ),
                ],
              ),
            ),
    );
  }
}
