// ignore_for_file: library_prefixes, prefer_const_constructors

import 'package:flutter/material.dart';

class MainColors {
  static Color? backgroundColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.backgroundColor;
  static Color? shadowColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.shadowColor;
  static Color? textColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.textColor;
  static Color? inputColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.inputColor;
  static Color? disableColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.disableColor;
  static Color? infoColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.infoColor;
  static Color? errorColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.errorColor;
  static Color? successColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.successColor;
  static Color? warningColor(BuildContext context) =>
      Theme.of(context).extension<ColorsStyles>()?.warningColor;

  static const Color primaryColor = Color(0xFF1A73E8); // Modern blue
  static const Color secondaryColor = Color(0xFF34A853); // Modern green
  static const Color categoryColor = Color(0xFF7F8C8D); // Modern green



  static const Color whiteColor = Colors.white;
  static const Color backgroundColorBottomSheet = Color(0xFFF5F7FA); // Light gray
  static const Color logoutColor = Color(0xFFEA4335); // Modern red
  static const Color transparentColor = Colors.transparent;

  static const Color blackColor = Color(0xFF202124); // Dark grayish black

  static const LinearGradient primaryGradientColor = LinearGradient(
    colors: [Color(0xFF1A73E8), Color(0xFF4285F4)],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: [0.2, 0.9],
  );

  static const LinearGradient acceptGradientColor = LinearGradient(
    colors: [Color(0xFF34A853), Color(0xFF81C784)],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.2, 0.9],
  );


}

class LightColors {
  static const Color backgroundColor = Color(0xFFFDFDFD); // Almost white
  static const Color shadowColor = Color(0xFFD6D6D6); // Light shadow gray
  static const Color textColor = Color(0xFF202124); // Dark grayish black
  static const Color inputColor = Color(0xFFF1F3F4); // Light input gray
  static const Color disableColor = Color(0xFFBDC1C6); // Muted gray
  static const Color infoColor = Color(0xFF4285F4); // Vibrant blue
  static const Color errorColor = Color(0xFFEA4335); // Vibrant red
  static const Color warningColor = Color(0xFFF9AB00); // Vibrant yellow
  static const Color successColor = Color(0xFF34A853); // Vibrant green
}

class DarkColors {
  static const Color backgroundColor = Color(0xFF202124); // Dark grayish black
  static const Color shadowColor = Color(0xFF3C4043); // Dark shadow gray
  static const Color textColor = Color(0xFFE8EAED); // Light grayish white
  static const Color inputColor = Color(0xFF303134); // Dark input gray
  static const Color disableColor = Color(0xFF5F6368); // Muted dark gray
  static const Color infoColor = Color(0xFF8AB4F8); // Soft blue
  static const Color errorColor = Color(0xFFF28B82); // Soft red
  static const Color warningColor = Color(0xFFFFD54F); // Soft yellow
  static const Color successColor = Color(0xFF81C784); // Soft green
}

@immutable
class ColorsStyles extends ThemeExtension<ColorsStyles> {
  const ColorsStyles({
    required this.backgroundColor,
    required this.disableColor,
    required this.textColor,
    required this.infoColor,
    required this.errorColor,
    required this.warningColor,
    required this.successColor,
    required this.shadowColor,
    required this.inputColor,
    // required this.fullLogo,
    // required this.iconLogo,
  });

  final Color? backgroundColor;
  final Color? disableColor;
  final Color? textColor;
  final Color? infoColor;
  final Color? errorColor;
  final Color? warningColor;
  final Color? successColor;
  final Color? shadowColor;
  final Color? inputColor;
  // final String? fullLogo;
  //final String? iconLogo;

  @override
  ColorsStyles copyWith({
    Color? backgroundColor,
    Color? disableColor,
    Color? textColor,
    Color? infoColor,
    Color? warningColor,
    Color? errorColor,
    Color? successColor,
    Color? shadowColor,
    Color? inputColor,
    Color? unSelectedColor,
    Color? cardColor,
    String? logo,
  }) {
    return ColorsStyles(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      disableColor: disableColor ?? this.disableColor,
      textColor: textColor ?? this.textColor,
      infoColor: infoColor ?? this.infoColor,
      warningColor: warningColor ?? this.warningColor,
      errorColor: errorColor ?? this.errorColor,
      successColor: successColor ?? this.successColor,
      inputColor: inputColor ?? this.inputColor,
      shadowColor: shadowColor ?? this.shadowColor,
      //fullLogo: fullLogo ?? fullLogo,
      // iconLogo: iconLogo ?? iconLogo,
    );
  }

  @override
  ColorsStyles lerp(ThemeExtension<ColorsStyles>? other, double t) {
    if (other is! ColorsStyles) {
      return this;
    }
    return ColorsStyles(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      disableColor: Color.lerp(disableColor, other.disableColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      infoColor: Color.lerp(infoColor, other.infoColor, t),
      warningColor: Color.lerp(warningColor, other.warningColor, t),
      errorColor: Color.lerp(errorColor, other.errorColor, t),
      successColor: Color.lerp(successColor, other.successColor, t),
      inputColor: Color.lerp(inputColor, other.inputColor, t),
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t),
      //fullLogo: fullLogo,
      //iconLogo: iconLogo,
    );
  }
}
