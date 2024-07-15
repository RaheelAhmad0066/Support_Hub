import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supporthub/appassets/color/colors.dart';
import 'package:supporthub/appassets/sizedbox_height.dart';
import 'package:supporthub/appassets/textstyle/textstyles.dart';
import 'package:supporthub/widgets/customelevatedvutton.dart';
import 'package:video_player/video_player.dart';

import 'Services/services.dart';
import 'controller/controller.dart';

class BookingSlotScreen extends StatelessWidget {
  final GroundDetail groundDetail;
  const BookingSlotScreen({super.key, required this.groundDetail});

  @override
  Widget build(BuildContext context) {
    final GroundController controller = Get.put(GroundController());

    // Initialize video controller with the video path from groundDetail
    controller.initializeVideo(groundDetail.videoUrl);

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Slot'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.primary,
        onPressed: () {},
        child: Icon(
          Iconsax.message,
          color: Colors.white,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppSizedBoxes.largeSizedBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 20,
                  width: 50,
                  decoration: AppDecoration.decorationBgColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        '4.6',
                        style: AppTextStyles.small,
                      ),
                      AppSizedBoxes.smallWidthSizedBox,
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 10,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 25,
                  width: 80,
                  decoration: AppDecoration.decorationBgColor,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      groundDetail.groundsize,
                      style: AppTextStyles.small,
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppSizedBoxes.normalSizedBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Welcome to the ${groundDetail.groundName}',
              style: AppTextStyles.mediumblack
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(groundDetail.description),
            ),
          ),
          AppSizedBoxes.normalSizedBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Ground Picture',
              style: AppTextStyles.mediumblack
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          AppSizedBoxes.normalSizedBox,
          CarouselSlider(
            options: CarouselOptions(
              height: 150.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 22 / 2,
              autoPlayInterval: Duration(seconds: 6),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: false,
              viewportFraction: 0.8,
            ),
            items: groundDetail.imageUrls.map((url) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: CustomColors.primary),
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: NetworkImage(url), fit: BoxFit.cover)),
                  );
                },
              );
            }).toList(),
          ),
          AppSizedBoxes.normalSizedBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              'Ground Video',
              style: AppTextStyles.mediumblack
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          AppSizedBoxes.normalSizedBox,
          Center(
            child: Container(
              decoration: AppDecoration.decorationWhite,
              height: Get.height * 0.2,
              width: Get.width * 0.9,
              child: GetBuilder<GroundController>(
                builder: (controller) {
                  if (!controller.isVideoInitialized.value) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        clipBehavior: Clip.hardEdge,
                        borderRadius: BorderRadius.circular(12),
                        child: AspectRatio(
                          aspectRatio:
                              controller.videoController.value.aspectRatio,
                          child: VideoPlayer(controller.videoController),
                        ),
                      ),
                      if (!controller.isPlaying.value)
                        IconButton(
                          icon: Icon(Icons.play_arrow,
                              size: 50, color: Colors.white),
                          onPressed: () {
                            controller.toggleVideoPlayback();
                          },
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
          Spacer(),
          Center(
              child: CustomButton(
            ontap: () {},
            title: 'Booking Slot',
            color: CustomColors.secondary,
          )),
          Spacer(),
        ],
      ),
    );
  }
}
