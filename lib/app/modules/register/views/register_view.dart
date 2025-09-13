import 'package:cars/app/core/components/bottoms/primary_button_component.dart';
import 'package:cars/app/core/components/inputs/imagepicker.dart';
import 'package:cars/app/core/components/inputs/text_input_component_labelinborder.dart';
import 'package:cars/app/core/constants/strings_assets_constants.dart';
import 'package:cars/app/models/frombackend/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cars/app/modules/register/controllers/register_controller.dart';

import 'package:cars/app/core/styles/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              MainColors.primaryColor.withOpacity(0.5),
              MainColors.primaryColor.withOpacity(0.1),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background decorative elements
            Positioned(
              top: -50.h,
              right: -30.w,
              child: Container(
                width: 200.w,
                height: 200.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MainColors.primaryColor.withOpacity(0.2),
                ),
              ),
            ),
            Positioned(
              bottom: -80.h,
              left: -50.w,
              child: Container(
                width: 250.w,
                height: 250.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: MainColors.primaryColor.withOpacity(0.15),
                ),
              ),
            ),

            // Main content
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),

                      // Back button
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios,
                            color: MainColors.primaryColor),
                        onPressed: () => Get.back(),
                      ),

                      SizedBox(height: 10.h),

                      // Profile Image Selection
                      Center(
                        child: CustomImagePicker(

                          
                          onImageSelected: (File) {
                            controller.selectedImage.value = File;
                          },
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // Header with animation
                      Center(
                        child: Column(
                          children: [
                            Text(
                              StringsAssetsConstants.joinUsToday,
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: MainColors.textColor(context),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              StringsAssetsConstants
                                  .createYourAccountToGetStarted,
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: MainColors.textColor(context)
                                    ?.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 25.h),

                      // User Type Selection
                      Container(
                        margin: EdgeInsets.only(bottom: 16.h),
                        child: Text(
                          "Select Account Type",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: MainColors.textColor(context),
                          ),
                        ),
                      ),

                      Obx(() => Container(
                            height: 70.h,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: Offset(0, 5),
                                )
                              ],
                              border: Border.all(
                                color: Colors.white.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              children: [
                                _buildUserTypeOption(
                                  context,
                                  UserType.client,
                                  'Client',
                                  Icons.person,
                                  controller.selectedUserType.value ==
                                      UserType.client,
                                ),
                                _buildUserTypeOption(
                                  context,
                                  UserType.store,
                                  'Store',
                                  Icons.store,
                                  controller.selectedUserType.value ==
                                      UserType.store,
                                ),
                              ],
                            ),
                          )),

                      SizedBox(height: 25.h),

                      Obx(
                        () => controller.selectedUserType == UserType.store
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    _buildSectionTitle(
                                        context, "Store information"),
                                    SizedBox(height: 15.h),
                                    TextInputComponentWithLabelInBorder(
                                      controller:
                                          controller.storenameController,
                                      label: 'Store Name',
                                      hint: 'Enter store name',
                                      prefixIcon: const Icon(
                                        Icons.store,
                                        color: MainColors.primaryColor,
                                      ),
                                    ),
                                    SizedBox(height: 15.h),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children:
                                            controller.daysOfWeek.map((day) {
                                          final isSelected = controller
                                              .selectedWeekends
                                              .contains(day);
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 4.w),
                                            child: FilterChip(
                                              label: Text(
                                                day,
                                                style: TextStyle(
                                                  color: isSelected
                                                      ? Colors.white
                                                      : MainColors.primaryColor,
                                                ),
                                              ),
                                              selected: isSelected,
                                              onSelected: (_) =>
                                                  controller.toggleWeekend(day),
                                              selectedColor:
                                                  MainColors.primaryColor,
                                              backgroundColor:
                                                  Colors.grey.shade200,
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ])
                            : SizedBox.shrink(),
                      ),
                      SizedBox(height: 15.h),

                      // Personal Information Section
                      _buildSectionTitle(context, "Personal Information"),

                      SizedBox(height: 15.h),
                      // Name fields in a row
                      TextInputComponentWithLabelInBorder(
                        controller: controller.nameController,
                        label: StringsAssetsConstants.firstName,
                        hint: StringsAssetsConstants.enterYourFirstName,
                        prefixIcon: const Icon(
                          Icons.person_outline,
                          color: MainColors.primaryColor,
                        ),
                      ),
                      TextInputComponentWithLabelInBorder(
                        controller: controller.famelynameController,
                        label: StringsAssetsConstants.familyName,
                        hint: StringsAssetsConstants.enterYourFamilyName,
                        prefixIcon: const Icon(
                          Icons.family_restroom,
                          color: MainColors.primaryColor,
                        ),
                      ),

                      SizedBox(height: 15.h),

                      // Email field
                      Obx(
                        () => TextInputComponentWithLabelInBorder(
                          controller: controller.emailController,
                          label: "Email Address",
                          hint: "Enter your email address",
                          textInputType: TextInputType.emailAddress,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            color: MainColors.primaryColor,
                          ),
                          validate: (p0) {
                            if (controller.emailerrortext == 'emailexist') {
                              return 'Email already in use';
                            }
                            return null;
                          },
                          errorText: controller.emailerrortext.value == null
                              ? null
                              : controller.emailerrortext.value,
                          onChanged: (value) {
                            controller.emailerrortext.value = null;
                          },
                        ),
                      ),
                      Obx(() => TextInputComponentWithLabelInBorder(
                            controller: controller.passwordController,
                            label: StringsAssetsConstants.password,
                            hint: StringsAssetsConstants.enterPassword,
                            obscureText: controller.isPasswordHidden.value,
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordHidden.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.black54,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                          )),

                      SizedBox(height: 15.h),

                      // Phone number field
                      TextInputComponentWithLabelInBorder(
                        controller: controller.phonenumberController,
                        label: StringsAssetsConstants.phoneNumber,
                        hint: StringsAssetsConstants.enterYourPhoneNumber,
                        textInputType: TextInputType.number,
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: MainColors.primaryColor,
                        ),
                      ),

                      SizedBox(height: 15.h),

                      // Birth date selection
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: GestureDetector(
                          onTap: () => controller.selectBirthDate(context),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 15.h),
                            decoration: BoxDecoration(
                              // color: Colors.white,
                              borderRadius: BorderRadius.circular(12.r),
                              border:
                                  Border.all(color: MainColors.primaryColor),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today,
                                    color: MainColors.primaryColor),
                                SizedBox(width: 12.w),
                                Obx(() => Text(
                                      controller.formattedBirthDate,
                                      style: TextStyle(
                                        color: controller
                                                    .selectedBirthDate.value ==
                                                null
                                            ? Colors.grey.shade500
                                            : MainColors.textColor(context),
                                        fontSize: 16.sp,
                                      ),
                                    )),
                                const Spacer(),
                                const Icon(Icons.arrow_drop_down,
                                    color: MainColors.primaryColor),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 25.h),

                      // Address Section
                      _buildSectionTitle(context, "Address Information"),

                      SizedBox(height: 15.h),

                      TextInputComponentWithLabelInBorder(
                        controller: controller.adressController,
                        label: StringsAssetsConstants.address,
                        hint: StringsAssetsConstants.enterYourAddress,
                        maxLines: 2,
                        prefixIcon: const Icon(
                          Icons.location_on_outlined,
                          color: MainColors.primaryColor,
                        ),
                      ),

                      SizedBox(height: 15.h),

                      // Wilaya and commune
                      TextInputComponentWithLabelInBorder(
                        controller: controller.wilayaController,
                        label: "Wilaya",
                        hint: "Enter your wilaya",
                        prefixIcon: const Icon(
                          Icons.map_outlined,
                          color: MainColors.primaryColor,
                        ),
                      ),
                      TextInputComponentWithLabelInBorder(
                        controller: controller.communeController,
                        label: "Commune",
                        hint: "Enter your commune",
                        prefixIcon: const Icon(
                          Icons.location_city,
                          color: MainColors.primaryColor,
                        ),
                      ),

                      SizedBox(height: 30.h),

                      // Register Button with animation
                      PrimaryButtonComponent(
                        onTap: controller.isLoading.value
                            ? () {}
                            : controller.handleRegistration,
                        text: StringsAssetsConstants.createAccount,
                        isLoading: controller.isLoading.value,
                        backgroundColor: MainColors.primaryColor,
                        textColor: MainColors.whiteColor,
                        borderRadius: BorderRadius.circular(28.r),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        iconLink: null,
                        width: double.infinity,
                        height: 56.h,
                      ),

                      SizedBox(height: 24.h),

                      // Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            StringsAssetsConstants.alreadyHaveAnAccount,
                            style: TextStyle(
                              color: MainColors.textColor(context)
                                  ?.withOpacity(0.7),
                              fontSize: 16.sp,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back(); // Navigate back to login
                            },
                            child: Text(
                              StringsAssetsConstants.signIn,
                              style: TextStyle(
                                color: MainColors.primaryColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserTypeOption(
    BuildContext context,
    UserType type,
    String title,
    IconData icon,
    bool isSelected,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeUserType(type),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.all(5.r),
          decoration: BoxDecoration(
            color: isSelected ? MainColors.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: MainColors.primaryColor.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ]
                : [],
          ),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : MainColors.primaryColor,
                ),
                SizedBox(width: 8.w),
                Text(
                  title,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : MainColors.textColor(context),
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
      padding: EdgeInsets.only(left: 5.w, right: 5.w, bottom: 5.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: MainColors.primaryColor.withOpacity(0.3), width: 2),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: MainColors.primaryColor,
        ),
      ),
    );
  }
}
