// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:cars/app/core/constants/strings_assets_constants.dart';
import 'package:string_validator/string_validator.dart';

class ValidatorUtil {
  static String? nullableValidation(var x, {String? customMessage}) {
    if (x == null)
      return customMessage ??
          StringsAssetsConstants.validatorDefaultErrorMessage;
    return null;
  }

  static String? imageFileValidation(File x, int maxSize,
      {String? customMessage}) {
    if (nullableValidation(x) == null) {
      final bytes = x.readAsBytesSync().lengthInBytes;
      final kb = bytes / 1024;
      final mb = kb / 1024;
      return mb < maxSize
          ? null
          : customMessage ??
              StringsAssetsConstants.validatorDefaultErrorMessage;
    }
    return null;
  }

  static String? emailValidation(String email, {String? customMessage}) {
    if (!isEmail(email)) {
      return customMessage ??
          StringsAssetsConstants.validatorDefaultErrorMessage;
    }
    return null;
  }

  static String? stringLengthValidation(String name, int length,
      {String? customMessage}) {
    if (!isLength(name, length)) {
      return customMessage ??
          StringsAssetsConstants.validatorDefaultErrorMessage;
    }
    return null;
  }

  static String? emptyValidation(String name, {String? customMessage}) {
    if (!isLength(name, 1)) {
      return customMessage ??
          StringsAssetsConstants.validatorDefaultErrorMessage;
    }
    return null;
  }

  // static String? numericValidation(String number, {String? customMessage}) {
  //   if (!isNumeric(number)) {
  //     return customMessage ??
  //         StringsAssetsConstants.validatorDefaultErrorMessage;
  //   }
  //   return null;
  // }

  // static String? phoneValidation(String phone, {String? customMessage}) {
  //   if (RegExp(r"^[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$").hasMatch(phone) !=
  //           true ||
  //       phone.length != 10 ||
  //       !(phone[0] == '6' || phone[0] == '7' || phone[0] == '5')) {
  //     return customMessage ??
  //         StringsAssetsConstants.validatorDefaultErrorMessage;
  //   }
  //   return null;
  // }

  static String? phoneValidation(String phone, {String? customMessage}) {
    if (RegExp(r"^[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$").hasMatch(phone) !=
            true ||
        phone.length != 10 ||
        !(phone[0] + phone[1] == '06' ||
            phone[0] + phone[1] == '05' ||
            phone[0] + phone[1] == '07')) {
      return customMessage ?? StringsAssetsConstants.phoneValidationMessage;
    }
    return null;
  }

  static String? passwordValidation(String password, {String? customMessage}) {
    if (!isLength(password, 8)) {
      return customMessage ?? StringsAssetsConstants.passwordValidationMessage;
    }
    return null;
  }

  static String? passwordConfirmationValidation(
      String confPassword, String password,
      {String? customMessage}) {
    if (!equals(password, confPassword)) {
      return customMessage ??
          StringsAssetsConstants.validatorDefaultErrorMessage;
    }
    return null;
  }
}
