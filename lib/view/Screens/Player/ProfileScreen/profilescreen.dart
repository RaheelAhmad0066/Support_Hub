import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supporthub/appassets/sizedbox_height.dart';

import '../Homescreen/Controller/homescontroller.dart';
import '../homescreen/Controller/homescontroller.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeScreenController());
    return Scaffold(
      body: Column(
        children: [
          AppSizedBoxes.largeSizedBox,
          AppSizedBoxes.largeSizedBox,
          AppSizedBoxes.largeSizedBox,
          CircleAvatar(
            child: Icon(Iconsax.user),
          ),
          Obx(() => Text('Useremail ${controller.userEmail.value}')),
          Obx(() => Text('Username ${controller.userName.value}')),
        ],
      ),
    );
  }
}
