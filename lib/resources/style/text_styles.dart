import 'package:covid/ui/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Text Styles
///
/// A color can be specified for a Text Style:
///
/// ```
///   TextStyles.h1(color: Colors.black);
/// ```
///
/// If not specified, it will defafult to [Colors.white]
class TextStyles {
  static TextStyle statisticsBig({Color color = Covid19Colors.darkGrey}) =>
      GoogleFonts.lato(
          textStyle: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 38.0,
        color: color,
      ));

  static TextStyle h1({Color color = Covid19Colors.darkGrey}) =>
      GoogleFonts.lato(
          textStyle: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 22.0,
        color: color,
      ));

  static TextStyle h2({Color color = Covid19Colors.darkGrey}) =>
      GoogleFonts.lato(
          textStyle: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 18.0,
        color: color,
      ));

  static TextStyle h3({Color color = Covid19Colors.darkGrey}) =>
      GoogleFonts.lato(
          textStyle: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 16.0,
        color: color,
      ));

  static TextStyle h4({Color color = Covid19Colors.darkGrey}) =>
      GoogleFonts.lato(
          textStyle: TextStyle(
        color: color,
        fontWeight: FontWeight.w900,
        fontSize: 14.0,
      ));

  static TextStyle h5({Color color = Covid19Colors.darkGrey}) =>
      GoogleFonts.lato(
          textStyle: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 12.0,
        color: color,
      ));

  // This style is named "link" in Figma and Zepplin
  static TextStyle button({Color color = Covid19Colors.darkGrey}) =>
      GoogleFonts.lato(
          textStyle: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 16.0,
        color: color,
      ));

  static TextStyle subtitle({Color color = Covid19Colors.darkGrey}) =>
      GoogleFonts.lato(
          textStyle: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 16.0,
        color: color,
      ));

  static TextStyle tabSelected({Color color = Covid19Colors.darkGrey}) =>
      GoogleFonts.lato(
          textStyle: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: 14.0,
        color: color,
      ));

  static TextStyle tabDeselected({Color color = Covid19Colors.darkGrey}) =>
      GoogleFonts.lato(
          textStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
        color: color,
      ));

  static TextStyle paragraphSmall({Color color = Covid19Colors.darkGrey}) =>
      GoogleFonts.lato(
          textStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 14.0,
        color: color,
      ));

  static TextStyle paragraphNormal({Color color = Covid19Colors.darkGrey}) =>
      GoogleFonts.lato(
          textStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 16.0,
        color: color,
      ));

  static TextStyle smallCaps({Color color = Covid19Colors.grey}) =>
      GoogleFonts.lato(
          textStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: 15.0,
        color: color,
      ));

  static TextStyle texCustom(
          {Color color = Covid19Colors.darkGrey, double size = 14.0}) =>
      GoogleFonts.lato(
          textStyle: TextStyle(
        fontWeight: FontWeight.normal,
        fontSize: size,
        color: color,
      ));
}
