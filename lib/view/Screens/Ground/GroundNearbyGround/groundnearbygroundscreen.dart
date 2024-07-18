import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supporthub/appassets/color/colors.dart';
import 'package:supporthub/appassets/sizedbox_height.dart';
import 'package:supporthub/appassets/textstyle/textstyles.dart';
import 'package:supporthub/view/Screens/Ground/GroundNearbyGround/groundmapscreen.dart';
import 'package:supporthub/widgets/customeTextfield.dart';
import 'package:supporthub/widgets/customelevatedvutton.dart';
import 'package:video_player/video_player.dart';
import '../GroundMainController/groundmaincontroller.dart';

class GroundNearbyGroundScreen extends StatelessWidget {
  GroundNearbyGroundScreen({super.key});
  final controller = Get.find<GroundMainController>();

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nearaby Ground',
          style: AppTextStyles.medium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSizedBoxes.largeSizedBox,
                    Text(
                      'Name*',
                      style: AppTextStyles.mediumblack
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    AppSizedBoxes.smallSizedBox,
                    CustomTextField(
                      hintText: 'Name',
                      obscureText: false,
                      onchange: (value) => controller.name.value = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your  name';
                        }
                        return null;
                      },
                    ),
                    AppSizedBoxes.normalSizedBox,
                    Text(
                      'Phone No*',
                      style: AppTextStyles.mediumblack
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    AppSizedBoxes.smallSizedBox,
                    CustomTextField(
                      hintText: 'Phone No',
                      obscureText: false,
                      onchange: (value) => controller.phoneNo.value = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your  phone number';
                        }
                        return null;
                      },
                    ),
                    AppSizedBoxes.normalSizedBox,
                    Text(
                      'Ground Name*',
                      style: AppTextStyles.mediumblack
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    AppSizedBoxes.smallSizedBox,
                    CustomTextField(
                      hintText: 'Ground Name',
                      obscureText: false,
                      onchange: (value) => controller.groundName.value = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your ground name';
                        }
                        return null;
                      },
                    ),
                    AppSizedBoxes.normalSizedBox,
                    Text(
                      'Ground Size*',
                      style: AppTextStyles.mediumblack
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    AppSizedBoxes.smallSizedBox,
                    CustomTextField(
                      hintText: 'Ground Size',
                      obscureText: false,
                      onchange: (value) => controller.groundSize.value = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your ground size';
                        }
                        return null;
                      },
                    ),
                    AppSizedBoxes.normalSizedBox,
                    Text(
                      'Ground Description*',
                      style: AppTextStyles.mediumblack
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    AppSizedBoxes.smallSizedBox,
                    CustomTextField(
                      hintText: 'Ground Description',
                      obscureText: false,
                      maxlines: 4,
                      onchange: (value) =>
                          controller.groundDescription.value = value!,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your ground description';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              AppSizedBoxes.normalSizedBox,
              Text(
                'Ground Images*',
                style: AppTextStyles.mediumblack
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Obx(() => Wrap(
                    runSpacing: 2,
                    spacing: 8,
                    children: [
                      for (int i = 0; i < controller.imagesList.length; i++)
                        Stack(
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: FileImage(
                                      File(controller.imagesList[i].path)),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: Icon(Icons.remove_circle),
                                onPressed: () => controller.removeDocument(i),
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: controller.pickDocument,
                        ),
                      ),
                    ],
                  )),
              AppSizedBoxes.normalSizedBox,
              Text(
                'Select Current Location*',
                style: AppTextStyles.mediumblack
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              AppSizedBoxes.smallSizedBox,
              InkWell(
                onTap: () async {
                  await controller.getCurrentLocation();
                  Get.to(() => GroundMapScreen());
                },
                child: Container(
                  height: Get.height * 0.07,
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.white,
                      border: Border.all(color: CustomColors.primary)),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.location,
                        color: CustomColors.secondary,
                      ),
                      Obx(() => Text(controller.locationName.value)),
                    ],
                  )),
                ),
              ),
              AppSizedBoxes.normalSizedBox,
              Text(
                'Pick Ground Video*',
                style: AppTextStyles.mediumblack
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              AppSizedBoxes.smallSizedBox,
              InkWell(
                onTap: () async {
                  controller.pickVideo();
                },
                child: Container(
                  height: Get.height * 0.07,
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(32),
                      color: Colors.white,
                      border: Border.all(color: CustomColors.primary)),
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Iconsax.video,
                        color: Colors.red,
                      ),
                      AppSizedBoxes.smallWidthSizedBox,
                      Text('Pick Video')
                    ],
                  )),
                ),
              ),
              AppSizedBoxes.normalSizedBox,
              Obx(() {
                if (controller.videoFile.value != null) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        height: 200,
                        width: Get.width,
                        child: controller.videoController.value != null &&
                                controller
                                    .videoController.value!.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: controller
                                    .videoController.value!.value.aspectRatio,
                                child: VideoPlayer(
                                    controller.videoController.value!),
                              )
                            : Center(child: CircularProgressIndicator()),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(controller
                                    .videoController.value!.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow),
                            onPressed: () {
                              if (controller
                                  .videoController.value!.value.isPlaying) {
                                controller.videoController.value!.pause();
                              } else {
                                controller.videoController.value!.play();
                              }
                              // Manually trigger update of UI
                              // because VideoPlayerController.value is not a Rx object
                              Get.forceAppUpdate();
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.stop),
                            onPressed: () {
                              controller.videoController.value!.pause();
                              controller.videoController.value!
                                  .seekTo(Duration.zero);
                              // Manually trigger update of UI
                              // because VideoPlayerController.value is not a Rx object
                              Get.forceAppUpdate();
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
              AppSizedBoxes.largeSizedBox,
              Center(
                child: Obx(
                  () => controller.isLoading.value
                      ? CircularProgressIndicator()
                      : CustomButton(
                          ontap: () {
                            controller.submitForm();
                          },
                          title: 'Saved'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
