import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supporthub/appassets/color/colors.dart';
import 'package:supporthub/appassets/sizedbox_height.dart';
import 'package:supporthub/appassets/textstyle/textstyles.dart';

import '../../../widgets/customelevatedvutton.dart';
import '../../auth/register.dart';

class OnboardingAcreen extends StatelessWidget {
  const OnboardingAcreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: Get.height * 0.8,
            color: CustomColors.primary,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 600),
            child: Container(
              height: Get.height * 0.3,
              color: CustomColors.secondary,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 480, left: 20),
            child: Container(
              height: Get.height * 0.3,
              width: Get.width * 0.9,
              decoration: AppDecoration.decorationWhite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    ontap: () {
                      Get.to(() => Registerscreen(isPlayer: true));
                    },
                    title: 'Register as Player',
                  ),
                  AppSizedBoxes.largeSizedBox,
                  CustomButton(
                    ontap: () {
                      Get.to(() => Registerscreen(isPlayer: false));
                    },
                    title: 'Register as Ground Owner',
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 70),
            child: Text(
              'Select \nYour Account Type',
              style: AppTextStyles.heading1.copyWith(fontSize: 53),
            ),
          )
        ],
      ),
    );
  }
}
