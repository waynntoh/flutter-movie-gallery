import 'package:flutter/material.dart';

class ResponsiveTextSize {
  static double responsiveTextSize(BuildContext context, double textSize) {
    double width = MediaQuery.of(context).size.width;
    return (width / 100 * textSize).roundToDouble();
  }
}
