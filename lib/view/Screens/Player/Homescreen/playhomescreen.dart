import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supporthub/appassets/color/colors.dart';
import 'package:supporthub/appassets/images/images.dart';
import 'package:supporthub/appassets/sizedbox_height.dart';
import 'package:supporthub/appassets/textstyle/textstyles.dart';
import 'package:supporthub/view/Screens/Player/Homescreen/Controller/homescontroller.dart';

import '../NearbyGround/Mybookings.dart';
import '../NearbyGround/nearbygroundscreen.dart';
import 'Weather/weatcher.dart';

class HomeScreenPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(Controller1());
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 5,
            backgroundColor: CustomColors.secondary,
            child: Icon(
              Iconsax.user,
              color: CustomColors.white,
            ),
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello,',
              style: AppTextStyles.small,
            ),
            Obx(() => Text(
                  homeController.userName.value,
                  style: AppTextStyles.small,
                )),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSizedBoxes.largeSizedBox,
              Text(
                'Category',
                style: AppTextStyles.heading1black.copyWith(fontSize: 16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(NearbyGroundScreen());
                        },
                        child: Image.asset(
                          CustomImages.myground,
                          width: 100,
                        ),
                      ),
                      Text(
                        'Nearaby Ground',
                        style: AppTextStyles.mediumblack
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(MyBookings());
                        },
                        child: Image.asset(
                          CustomImages.mybooking,
                          width: 100,
                        ),
                      ),
                      Text(
                        'My Booking',
                        style: AppTextStyles.mediumblack
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              AppSizedBoxes.largeSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(WeatherScreen());
                        },
                        child: Image.asset(
                          CustomImages.wather,
                          width: 80,
                        ),
                      ),
                      Text(
                        'Weather Update',
                        style: AppTextStyles.mediumblack
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Image.asset(
                        CustomImages.tournament,
                        width: 80,
                      ),
                      Text(
                        'Tournaments',
                        style: AppTextStyles.mediumblack
                            .copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
