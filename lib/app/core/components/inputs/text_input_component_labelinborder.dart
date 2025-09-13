// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';

/// A custom text input component with a label inside the border.
/// Features floating label behavior and customizable styling.
class TextInputComponentWithLabelInBorder extends StatelessWidget {
  final bool mustfill;
  final FocusNode? focusNode;
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? errorText;
  double? width;
  final TextInputType? textInputType;
  final bool obscureText;
  final bool readOnly;
  final bool autoFocus;
  final int maxLines;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final Function(String)? validate;
  final double? heightTextFormField;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? filled;

  TextInputComponentWithLabelInBorder({
    super.key,
    this.mustfill = false,
    required this.controller,
    required this.label,
    this.width,
    this.filled = false,
    this.focusNode,
    this.hint,
    this.errorText,
    this.textInputType,
    this.obscureText = false,
    this.readOnly = false,
    this.autoFocus = false,
    this.maxLines = 1,
    this.maxLength,
    this.textInputAction,
    this.onChanged,
    this.onSubmit,
    this.validate,
    this.heightTextFormField,
    this.suffixIcon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 8.h),
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            keyboardType: textInputType ?? TextInputType.text,
            obscureText: obscureText,
            readOnly: readOnly,
            autofocus: autoFocus,
            maxLines: maxLines,
            maxLength: maxLength,
            textInputAction: textInputAction ?? TextInputAction.done,
            style: (errorText != null && errorText!.isNotEmpty)
                ? TextStyles.bodyMedium(context)
                    .copyWith(color: MainColors.errorColor(context))
                : TextStyles.bodyMedium(context),
            cursorColor: MainColors.textColor(context),
            decoration: InputDecoration(
              labelText: mustfill ? '$label *' : label,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyles.labelMedium(context).copyWith(
                color: MainColors.textColor(context)!.withOpacity(0.7),
              ),
              hintText: hint,
              hintStyle: TextStyles.labelSmall(context).copyWith(
                color: MainColors.textColor(context)!.withOpacity(0.4),
              ),
              fillColor: MainColors.backgroundColor(context)!.withOpacity(0.1),
              filled: filled ?? true,
              counterText: '',
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(
                  color: MainColors.textColor(context)!.withOpacity(0.4),
                  width: 1,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13.r),
                borderSide: BorderSide(
                  color: MainColors.textColor(context)!.withOpacity(0.4),
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13.r),
                borderSide: const BorderSide(
                  color: MainColors.primaryColor,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13.r),
                borderSide: BorderSide(
                  color: MainColors.errorColor(context)!,
                  width: 1,
                ),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13.r),
                borderSide: BorderSide(
                  color: MainColors.errorColor(context)!,
                  width: 1.5,
                ),
              ),
            ),
            validator:
                validate != null ? (value) => validate!(value ?? "") : null,
            onFieldSubmitted: (value) => onSubmit?.call(value),
            onChanged: onChanged,
          ),
        ),
        if (errorText != null && errorText!.isNotEmpty)
          Center(
            child: Text(
              errorText!,
              style: TextStyles.bodySmall(context).copyWith(
                fontWeight: FontWeight.bold,
                color: MainColors.errorColor(context),
              ),
            ),
          ),
      ],
    );
  }
}
