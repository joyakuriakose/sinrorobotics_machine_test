import 'dart:ui';
import 'package:flutter/material.dart';


class MyTheme {
  static MaterialColor primaryColor1 = Colors.blue;
  static Color whiteColor = const Color(0xFFFFFFFF);
  static Color myBlueDark = const Color.fromRGBO(0, 0, 128, 1);
  static Color dashBack = const Color(0x00FFFDFD);
  static Color appColor = const Color.fromRGBO(77, 82, 225, 1);

  // static TextStyle regularTextStyle(
  //     BuildContext context, {
  //       Color? color,
  //       double? fontSize,
  //       FontWeight? fontWeight,
  //       double? letterSpacing,
  //     }) {
  //   final textScaleFactor = MediaQuery.of(context).textScaleFactor;
  //   return GoogleFonts.inter(
  //     color: color ?? Colors.white,
  //     fontSize: fontSize != null ? fontSize / textScaleFactor : 15,
  //     fontWeight: fontWeight ?? FontWeight.normal,
  //     letterSpacing: letterSpacing,
  //   );
  // }

  // static TextStyle labelTextStyle({
  //   Color? color,
  //   double? textSize,
  //   FontWeight? fontWeight,
  //   double? letterSpacing,
  // }) {
  //   final textScaleFactor =
  //       PlatformDispatcher.instance.views.first.textScaleFactor;
  //   return GoogleFonts.inter(
  //     color: color ?? const Color(0XFF3A3A3A).withOpacity(0.8),
  //     fontSize: textSize != null ? textSize / textScaleFactor : 15,
  //     fontWeight: fontWeight ?? FontWeight.normal,
  //     letterSpacing: letterSpacing,
  //   );
  // }
}
