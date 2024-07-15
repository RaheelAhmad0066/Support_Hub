import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supporthub/appassets/images/images.dart';
import 'package:supporthub/appassets/textstyle/textstyles.dart';
import 'package:supporthub/view/ScreenS/splash/controller/splashcontroller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SplashController());
    return Scaffold(
        body: Container(
      height: Get.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(CustomImages.splash), fit: BoxFit.fitWidth)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: Get.height * 0.6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Easy and Quick Online Booking',
              style: AppTextStyles.heading1.copyWith(fontSize: 60),
            ),
          )
        ],
      ),
    ));
  }
}
