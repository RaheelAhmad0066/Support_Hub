import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supporthub/appassets/color/colors.dart';

import '../appassets/textstyle/textstyles.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final VoidCallback ontap;
  final Color? color;
  const CustomButton({
    required this.ontap,
    required this.title,
    this.color = CustomColors.primary,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.8,
      height: Get.height * 0.06,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12))),
          onPressed: ontap,
          child: Text(
            title,
            style: AppTextStyles.medium,
          )),
    );
  }
}
