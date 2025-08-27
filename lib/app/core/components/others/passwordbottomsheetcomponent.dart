import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cars/app/core/components/inputs/text_input_component_labelinborder.dart';
import 'package:cars/app/core/constants/logos_assets_constants.dart';
import 'package:cars/app/core/constants/strings_assets_constants.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/text_styles.dart';
import 'package:cars/app/core/components/bottoms/primary_button_component.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordBottomSheetComponent extends StatefulWidget {
  final Function(String)? onSubmit;

  const PasswordBottomSheetComponent({
    Key? key,
    this.onSubmit,
  }) : super(key: key);

  @override
  State<PasswordBottomSheetComponent> createState() =>
      _PasswordBottomSheetComponentState();
}

class _PasswordBottomSheetComponentState
    extends State<PasswordBottomSheetComponent> {
  final TextEditingController _controller = TextEditingController();
  bool _showPassword = false;
  bool isObscureText = true;
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40.w,
            height: 4.w,
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: MainColors.shadowColor(context),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 25.h),
          // Title and Image row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 12.r),
                child: Image.asset(
                  LogosAssetsConstants.passwordlogo,
                  width: 40.w,
                  height: 40.w,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                StringsAssetsConstants.enterPassword,
                style: TextStyles.titleMedium(context)
                    .copyWith(fontSize: 18.sp, color: MainColors.primaryColor),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          // Text field
          TextInputComponentWithLabelInBorder(
            filled: false,
            controller: _controller,
            label: StringsAssetsConstants.enterPassword,
            obscureText: isObscureText && !_showPassword,
            suffixIcon: isObscureText
                ? InkWell(
                    onTap: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8.r),
                      child: Icon(
                        _showPassword
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        size: 5.w,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(height: 10.h),
          // Submit button
          PrimaryButtonComponent(
            onTap: () {
              if (widget.onSubmit != null) {
                widget.onSubmit!(_controller.text);
              }
            },
            text: StringsAssetsConstants.confirmPassword,
            height: 48.h,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}

// Usage example:
// showModalBottomSheet(
//   context: context,
//   isScrollControlled: true,
//   builder: (context) => PasswordBottomSheetComponent(
//     title: "Enter Password",
//     imageAsset: "assets/images/lock_icon.png",
//     onSubmit: (password) {
//       // Handle password
//     },
//   ),
// );