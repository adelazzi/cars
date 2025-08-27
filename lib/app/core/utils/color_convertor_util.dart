// import 'package:cars/app/core/styles/colors.dart';
import 'package:cars/app/core/styles/colors.dart';
import 'package:flutter/material.dart';

class ColorConvertorUtil {
  Color stringColorCodeToColor(String? color) {
    if (color == null ||
        color == "" ||
        color.contains("#") == false ||
        color == "null") return MainColors.whiteColor;
    color = color.replaceAll("#", "");
    Color convertedColor = MainColors.whiteColor;
    if (color.length == 6) {
      convertedColor = Color(int.parse("0xFF$color"));
    } else if (color.length == 8) {
      convertedColor = Color(int.parse("0x$color"));
    }
    return convertedColor;
  }

  String colorToStringColorCode(Color color) {
    String value =
        color.toString().split('(0x')[1].split(')')[0].replaceFirst("ff", "#");
    return value;
  }
}
