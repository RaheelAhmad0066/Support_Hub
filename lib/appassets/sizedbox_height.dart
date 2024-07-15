import 'package:flutter/material.dart';
import 'package:supporthub/appassets/color/colors.dart';

class AppSizedBoxes {
  static const SizedBox normalSizedBox = SizedBox(height: 16.0);
  static const SizedBox smallSizedBox = SizedBox(height: 8.0);
  static const SizedBox largeSizedBox = SizedBox(height: 32.0);

  static const SizedBox normalWidthSizedBox = SizedBox(width: 16.0);
  static const SizedBox smallWidthSizedBox = SizedBox(width: 8.0);
  static const SizedBox largeWidthSizedBox = SizedBox(width: 32.0);
  // Add more SizedBox values as needed
}

class AppDecoration {
  static final decorationWhite = BoxDecoration(
      borderRadius: BorderRadius.circular(26), color: CustomColors.white);
  static final decorationBgColor = BoxDecoration(
      borderRadius: BorderRadius.circular(7), color: CustomColors.primary);
}
